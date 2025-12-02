"""
Leaflow 容器化部署入口文件
使用 schedule 库实现定时任务调度，让容器保持常驻运行
"""

import os
import sys
import time
import schedule
import subprocess
import logging
from datetime import datetime

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('scheduler.log', encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


def run_script(script_name: str, task_name: str):
    """
    执行脚本
    
    Args:
        script_name: 脚本文件名
        task_name: 任务名称（用于日志）
    """
    try:
        logger.info(f"========== 开始执行 {task_name} ==========")
        logger.info(f"时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
        # 设置环境变量，强制无头模式
        env = os.environ.copy()
        env['GITHUB_ACTIONS'] = 'true'
        
        # 执行脚本
        result = subprocess.run(
            [sys.executable, script_name],
            env=env,
            capture_output=True,
            text=True,
            timeout=600  # 10分钟超时
        )
        
        # 打印输出
        if result.stdout:
            logger.info(f"标准输出:\n{result.stdout}")
        
        if result.stderr:
            logger.warning(f"标准错误:\n{result.stderr}")
        
        # 检查返回码
        if result.returncode == 0:
            logger.info(f"✅ {task_name} 执行成功")
        else:
            logger.error(f"❌ {task_name} 执行失败，返回码: {result.returncode}")
        
        logger.info(f"========== {task_name} 执行结束 ==========\n")
        
    except subprocess.TimeoutExpired:
        logger.error(f"❌ {task_name} 执行超时（超过10分钟）")
    except Exception as e:
        logger.error(f"❌ {task_name} 执行出错: {e}")
        import traceback
        logger.error(traceback.format_exc())


def job_checkin():
    """打卡任务"""
    run_script('auto_checkin.py', '自动打卡')


def job_daily_report():
    """日报任务"""
    run_script('auto_daily_report.py', '自动日报')


def main():
    """主函数 - 设置定时任务并保持运行"""
    
    # 打印启动信息
    logger.info("=" * 60)
    logger.info("🚀 Leaflow 自动化容器启动")
    logger.info("=" * 60)
    logger.info(f"启动时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    logger.info(f"时区: {time.tzname}")
    
    # 检查环境变量
    username = os.getenv('CHECKIN_USERNAME', '')
    if username:
        logger.info(f"用户名: {username}")
    else:
        logger.warning("⚠️ 未设置 CHECKIN_USERNAME 环境变量")
    
    if not os.getenv('CHECKIN_PASSWORD'):
        logger.warning("⚠️ 未设置 CHECKIN_PASSWORD 环境变量")
    
    # 设置定时任务
    logger.info("\n📅 配置定时任务:")
    
    # 任务 A: 每天 08:00 和 17:00 执行打卡
    schedule.every().day.at("08:00").do(job_checkin)
    schedule.every().day.at("17:00").do(job_checkin)
    logger.info("  ✓ 任务 A: 每天 08:00 和 17:00 执行自动打卡")
    
    # 任务 B: 每天 19:00 执行日报
    schedule.every().day.at("19:00").do(job_daily_report)
    logger.info("  ✓ 任务 B: 每天 19:00 执行自动日报")
    
    logger.info("\n✅ 定时任务配置完成，容器将保持常驻运行")
    logger.info("=" * 60)
    
    # 立即执行一次（可选，用于测试）
    # 如果你想在容器启动时立即执行一次，可以取消下面的注释
    # logger.info("\n🔄 容器启动时执行一次任务...")
    # job_checkin()
    # job_daily_report()
    
    # 主循环 - 保持容器运行
    logger.info("\n⏰ 开始监听定时任务...\n")
    
    while True:
        try:
            # 检查并运行待执行的任务
            schedule.run_pending()
            
            # 每60秒检查一次
            time.sleep(60)
            
        except KeyboardInterrupt:
            logger.info("\n收到退出信号，正在停止...")
            break
        except Exception as e:
            logger.error(f"调度器出错: {e}")
            import traceback
            logger.error(traceback.format_exc())
            # 出错后等待一会儿再继续
            time.sleep(60)


if __name__ == "__main__":
    main()
