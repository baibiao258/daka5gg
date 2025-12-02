# 使用微软官方 Playwright 镜像（包含 Python 3.10+ 和浏览器环境）
FROM mcr.microsoft.com/playwright:v1.40.0-jammy

# 设置工作目录
WORKDIR /app

# 设置时区为 Asia/Shanghai（非常重要！）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置环境变量
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# 复制依赖文件
COPY requirements.txt .

# 升级 pip 并安装 Python 依赖
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt

# 复制项目文件
COPY . .

# 暴露端口（如果需要的话，Leaflow 可能需要）
# EXPOSE 8000

# 设置健康检查（可选）
HEALTHCHECK --interval=5m --timeout=3s \
    CMD test -f /app/scheduler.log || exit 1

# 容器启动时运行调度器
CMD ["python", "main.py"]
