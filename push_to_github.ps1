# ========================================
# Windows PowerShell 命令 - 推送到 GitHub
# ========================================

# 1. 进入项目目录
cd "c:\Users\BAI\Desktop\自动打卡2\daka3"

# 2. 检查当前远程仓库地址
git remote -v

# 3. 强制修改远程仓库地址（确保指向正确的仓库）
git remote set-url origin https://github.com/baibiao258/dakajingxiang.git

# 4. 验证远程仓库地址已更新
git remote -v

# 5. 查看当前文件状态
git status

# 6. 添加所有新文件和修改
git add .

# 7. 查看将要提交的文件
git status

# 8. 提交更改
git commit -m "feat: 添加 GitHub Actions 自动构建配置

- 添加 .github/workflows/docker-build.yml
- 配置自动构建并推送到 ghcr.io
- 镜像地址: ghcr.io/baibiao258/dakajingxiang:latest
- 添加 GITHUB_ACTIONS_GUIDE.md 使用指南

自动化流程：
- 推送代码触发 GitHub Actions
- 自动构建 Docker 镜像
- 推送到 GitHub Container Registry
- 可直接在 Leaflow 使用镜像地址"

# 9. 推送到 GitHub（这会触发自动构建）
git push origin main

# 10. 完成提示
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ 推送成功！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "🔄 GitHub Actions 正在自动构建 Docker 镜像..." -ForegroundColor Yellow
Write-Host ""
Write-Host "📋 下一步操作：" -ForegroundColor Cyan
Write-Host "1. 访问 GitHub Actions 查看构建进度：" -ForegroundColor White
Write-Host "   https://github.com/baibiao258/dakajingxiang/actions" -ForegroundColor Gray
Write-Host ""
Write-Host "2. 等待构建完成（约 5-10 分钟）" -ForegroundColor White
Write-Host ""
Write-Host "3. 将镜像设置为公开（如果 Leaflow 无法访问私有镜像）：" -ForegroundColor White
Write-Host "   https://github.com/baibiao258/dakajingxiang/pkgs/container/dakajingxiang" -ForegroundColor Gray
Write-Host ""
Write-Host "4. 在 Leaflow 使用以下镜像地址：" -ForegroundColor White
Write-Host "   ghcr.io/baibiao258/dakajingxiang:latest" -ForegroundColor Green
Write-Host ""
Write-Host "📖 详细说明请查看：GITHUB_ACTIONS_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
