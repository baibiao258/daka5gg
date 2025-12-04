#!/bin/bash

echo "========================================"
echo "🚀 开始推送到 GitHub 仓库"
echo "========================================"
echo ""

# 进入daka3目录
cd "$(dirname "$0")"
echo "📁 当前目录: $(pwd)"
echo ""

# 检查Git是否已初始化
if [ ! -d ".git" ]; then
    echo "🔄 初始化 Git 仓库..."
    git init
    echo ""
fi

# 配置远程仓库
echo "🔗 配置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/baibiao258/dakajingxiang.git
echo "✅ 远程仓库地址: https://github.com/baibiao258/dakajingxiang.git"
echo ""

# 设置分支
echo "🌿 设置主分支..."
git branch -M main
echo ""

# 添加所有文件
echo "📦 添加文件..."
git add .
echo ""

# 检查是否有文件要提交
if git diff --staged --quiet; then
    echo "⚠️  没有要提交的文件"
else
    # 创建提交
    echo "💾 创建提交..."
    git commit -m "feat: 完整的自动打卡与日报系统

✨ 核心功能:
- 自动打卡 (每天08:00, 17:00)
- 自动日报 (每天19:00)
- GitHub Actions 自动构建Docker镜像
- 容器化部署支持

🛠️ 技术栈:
- Playwright 浏览器自动化
- Docker 容器化部署
- GitHub Actions CI/CD
- 验证码自动识别 (ddddocr)
- 定时任务调度 (schedule)

📦 部署方案:
- GitHub Container Registry
- Leaflow 容器平台
- 本地Docker部署

📖 文档完整:
- README.md 项目说明
- DEPLOY.md 详细部署指南  
- QUICKSTART.md 快速开始
- BUILD_GUIDE.md 构建指南
- GITHUB_ACTIONS_GUIDE.md Actions使用指南"

    echo ""
    echo "🚀 推送到 GitHub..."
    git push -u origin main --force
    
    echo ""
    echo "========================================"
    echo "✅ 推送成功！"
    echo "========================================"
    echo ""
    echo "🔄 GitHub Actions 正在自动构建 Docker 镜像..."
    echo ""
    echo "📋 下一步操作："
    echo "1. 查看构建进度: https://github.com/baibiao258/dakajingxiang/actions"
    echo "2. 等待构建完成 (约5-10分钟)"
    echo "3. 设置镜像为公开: https://github.com/baibiao258/dakajingxiang/pkgs/container/dakajingxiang"
    echo "4. 在Leaflow使用镜像: ghcr.io/baibiao258/dakajingxiang:latest"
    echo ""
    echo "📖 详细说明请查看: BUILD_GUIDE.md"
fi