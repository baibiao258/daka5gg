# 🚀 GitHub Actions 自动构建 Docker 镜像指南

## ✅ 已配置的 GitHub Actions

### 🎯 配置文件
- **`.github/workflows/docker-build.yml`** - 自动构建工作流
- **镜像仓库**: GitHub Container Registry (ghcr.io)
- **镜像地址**: `ghcr.io/baibiao258/dakajingxiang:latest`

### 🔄 触发条件
- ✅ 推送到 `main` 分支时自动触发
- ✅ 支持手动触发 (workflow_dispatch)

---

## 📋 操作步骤

### 步骤 1️⃣：推送代码到 GitHub

**一键推送脚本**：
```powershell
# 双击运行或在 PowerShell 中执行
./push_to_github.ps1
```

**手动推送**：
```cmd
# 进入项目目录
cd "c:\Users\BAI\Desktop\自动打卡2\daka3"

# 添加文件
git add .

# 提交更改
git commit -m "feat: 配置 GitHub Actions 自动构建 Docker 镜像"

# 推送到 GitHub
git push origin main
```

### 步骤 2️⃣：查看构建进度

1. **访问 GitHub Actions**：
   ```
   https://github.com/baibiao258/dakajingxiang/actions
   ```

2. **查看工作流运行状态**：
   - 点击最新的工作流运行
   - 等待构建完成（约 5-10 分钟）

3. **构建流程**：
   ```
   ✅ 检出代码 → ✅ 登录 GitHub Container Registry → ✅ 提取元数据 
   → ✅ 设置 Docker Buildx → ✅ 构建和推送镜像
   ```

### 步骤 3️⃣：设置镜像为公开

如果 Leaflow 无法访问私有镜像，需要设置公开：

1. **访问镜像页面**：
   ```
   https://github.com/baibiao258/dakajingxiang/pkgs/container/dakajingxiang
   ```

2. **设置公开**：
   - 点击 "Package settings"
   - 滚动到底部
   - 点击 "Change visibility"
   - 选择 "Public"
   - 确认更改

### 步骤 4️⃣：在 Leaflow 部署

#### 镜像信息
- **镜像地址**: `ghcr.io/baibiao258/dakajingxiang:latest`
- **标签**: latest (最新版本)

#### 环境变量配置
| 变量名 | 值 | 说明 |
|--------|-----|------|
| `CHECKIN_USERNAME` | 你的用户名 | 登录账号 |
| `CHECKIN_PASSWORD` | 你的密码 | 登录密码 |
| `GITHUB_ACTIONS` | `true` | ⚠️ 必须，强制无头模式 |

#### 资源限制
- **CPU**: `500m` - `1000m`
- **内存**: `1024 MiB` (最少 1GB)

---

## 🔧 手动触发构建

如需手动重新构建镜像：

1. **访问 Actions 页面**：
   ```
   https://github.com/baibiao258/dakajingxiang/actions
   ```

2. **运行工作流**：
   - 点击 "Build and Push Docker Image"
   - 点击 "Run workflow"
   - 选择 `main` 分支
   - 点击 "Run workflow"

---

## ⚡ 构建产物

### 镜像标签
- `latest` - 最新版本
- `main-<commit-sha>` - 基于提交哈希的版本

### 镜像大小
- 约 **2GB** (包含 Playwright 和浏览器)

### 镜像内容
- ✅ Python 3.11 环境
- ✅ Playwright + Chromium 浏览器
- ✅ 所有项目代码
- ✅ Python 依赖包
- ✅ 时区配置 (Asia/Shanghai)

---

## 🎯 定时任务

容器启动后自动执行：

| 任务 | 执行时间 | 脚本 |
|------|----------|------|
| 🔔 自动打卡 | 08:00, 17:00 | auto_checkin.py |
| 📝 自动日报 | 19:00 | auto_daily_report.py |

---

## 🛠️ 故障排查

### ❌ 构建失败
**检查**：
1. GitHub Actions 日志
2. Dockerfile 语法
3. requirements.txt 格式
4. 网络连接

### ❌ 镜像拉取失败
**解决**：
1. 确保镜像为公开状态
2. 检查镜像地址拼写
3. 确认 Leaflow 网络权限

### ❌ 容器启动失败
**检查**：
1. 环境变量是否正确设置
2. 资源限制是否充足
3. 查看容器日志

---

## 📞 支持

- **构建日志**: GitHub Actions 页面
- **部署文档**: DEPLOY.md
- **快速指南**: QUICKSTART.md
- **Actions 指南**: GITHUB_ACTIONS_GUIDE.md

---

**祝构建成功！** 🎉