# GitHub Container Registry Token 设置指南

## 问题原因
`GITHUB_TOKEN` 默认权限不足，无法推送镜像到 GitHub Container Registry (GHCR)。

## 解决方案：创建 Personal Access Token (PAT)

### 步骤 1：创建 Personal Access Token

1. 访问 GitHub Token 设置页面：
   https://github.com/settings/tokens

2. 点击 **"Generate new token"** → 选择 **"Generate new token (classic)"**

3. 填写信息：
   - **Note**: `GHCR Token for daka5gg` (或任何你喜欢的名称)
   - **Expiration**: 建议选择 **No expiration** 或 **1 year**
   
4. 选择权限（Scopes）：
   - ✅ `write:packages` - 推送镜像到 GHCR
   - ✅ `read:packages` - 拉取镜像
   - ✅ `delete:packages` - 删除旧镜像（可选）
   - ✅ `repo` - 如果仓库是私有的（可选）

5. 点击 **"Generate token"**

6. **重要**：立即复制生成的 token（格式类似：`ghp_xxxxxxxxxxxxxxxxxxxx`）
   - Token 只显示一次，离开页面后无法再查看
   - 如果忘记复制，需要重新生成

### 步骤 2：添加 Token 到仓库 Secrets

1. 访问你的仓库设置：
   https://github.com/baibiao258/daka5gg/settings/secrets/actions

2. 点击 **"New repository secret"**

3. 填写信息：
   - **Name**: `GHCR_TOKEN` （必须是这个名称）
   - **Secret**: 粘贴刚才复制的 token

4. 点击 **"Add secret"**

### 步骤 3：推送更新的工作流

```bash
cd "打卡镜像/自动打卡镜像/daka3"
git add .github/workflows/docker-build.yml GHCR_TOKEN_SETUP.md
git commit -m "修复：使用 PAT 替代 GITHUB_TOKEN 推送到 GHCR"
git push origin main
```

### 步骤 4：验证

1. 推送代码后，GitHub Actions 会自动运行
2. 访问 Actions 页面查看构建状态：
   https://github.com/baibiao258/daka5gg/actions

3. 如果成功，你会看到镜像出现在：
   https://github.com/baibiao258/daka5gg/pkgs/container/daka5gg

## 常见问题

### Q: 为什么不能用 GITHUB_TOKEN？
A: `GITHUB_TOKEN` 是 GitHub Actions 自动生成的临时 token，虽然设置了 `packages: write` 权限，但在某些情况下仍然无法推送到 GHCR。使用 PAT 是更可靠的方案。

### Q: Token 会过期吗？
A: 如果选择了过期时间，到期后需要重新生成并更新 Secret。建议选择较长的过期时间或不过期。

### Q: Token 安全吗？
A: GitHub Secrets 是加密存储的，只有仓库的 Actions 可以访问。不要在代码或日志中暴露 token。

### Q: 可以用同一个 Token 给多个仓库吗？
A: 可以，但建议为每个项目创建独立的 token，方便管理和撤销。

## 镜像使用

构建成功后，可以使用以下命令拉取镜像：

```bash
# 拉取最新版本
docker pull ghcr.io/baibiao258/daka5gg:latest

# 拉取特定版本
docker pull ghcr.io/baibiao258/daka5gg:v123
```

在 Leaflow 或其他容器平台使用：
```
ghcr.io/baibiao258/daka5gg:latest
```
