# Windows PowerShell 推送脚本
Write-Host "========================================" -ForegroundColor Green
Write-Host "🚀 开始推送到 GitHub 仓库" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# 切换到daka3目录
Set-Location "daka3"
Write-Host "📁 当前目录: $(Get-Location)" -ForegroundColor Yellow
Write-Host ""

# 检查Git是否已初始化
if (-not (Test-Path ".git")) {
    Write-Host "🔄 初始化 Git 仓库..." -ForegroundColor Cyan
    git init
    Write-Host ""
}

# 配置远程仓库
Write-Host "🔗 配置远程仓库..." -ForegroundColor Cyan
git remote remove origin 2>$null
git remote add origin https://github.com/baibiao258/dakajingxiang.git
Write-Host "✅ 远程仓库地址: https://github.com/baibiao258/dakajingxiang.git" -ForegroundColor Green
Write-Host ""

# 设置分支
Write-Host "🌿 设置主分支..." -ForegroundColor Cyan
git branch -M main
Write-Host ""

# 添加所有文件
Write-Host "📦 添加文件..." -ForegroundColor Cyan
git add .
Write-Host ""

# 检查是否有文件要提交
$hasChanges = git diff --staged --quiet
if (-not $hasChanges) {
    # 创建提交
    Write-Host "💾 创建提交..." -ForegroundColor Cyan
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

    Write-Host ""
    Write-Host "🚀 推送到 GitHub..." -ForegroundColor Cyan
    git push -u origin main --force
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✅ 推送成功！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "🔄 GitHub Actions 正在自动构建 Docker 镜像..." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "📋 下一步操作：" -ForegroundColor Cyan
    Write-Host "1. 查看构建进度: https://github.com/baibiao258/dakajingxiang/actions" -ForegroundColor White
    Write-Host "2. 等待构建完成 (约5-10分钟)" -ForegroundColor White
    Write-Host "3. 设置镜像为公开: https://github.com/baibiao258/dakajingxiang/pkgs/container/dakajingxiang" -ForegroundColor White
    Write-Host "4. 在Leaflow使用镜像: ghcr.io/baibiao258/dakajingxiang:latest" -ForegroundColor White
    Write-Host ""
    Write-Host "📖 详细说明请查看: BUILD_GUIDE.md" -ForegroundColor Cyan
} else {
    Write-Host "⚠️ 没有要提交的文件" -ForegroundColor Yellow
}