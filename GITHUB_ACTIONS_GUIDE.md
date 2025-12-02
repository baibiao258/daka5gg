# 🚀 使用 GitHub Actions 自动构建 Docker 镜像

## ✅ 已完成的配置

本项目已配置 GitHub Actions，会在每次推送到 `main` 分支时自动构建 Docker 镜像并推送到 **GitHub Container Registry (ghcr.io)**。

---

## 📦 文件清单

### ✅ 核心文件
- **`requirements.txt`** - Python 依赖：`playwright`, `schedule`, `requests`, `ddddocr`, `Pillow`
- **`main.py`** - 调度脚本（包含定时任务和容器保活）
- **`Dockerfile`** - 基于 `mcr.microsoft.com/playwright:v1.40.0-jammy`
- **`.github/workflows/docker-build.yml`** - GitHub Actions 自动构建配置

---

## 🔄 自动构建流程

### 触发条件
- ✅ 推送到 `main` 分支
- ✅ 手动触发（workflow_dispatch）

### 构建产物
镜像地址：**`ghcr.io/baibiao258/dakajingxiang:latest`**

---

## 🎯 如何使用

### 步骤 1：推送代码到 GitHub（触发自动构建）

在 Windows PowerShell 中执行：

```powershell
# 进入项目目录
cd "c:\Users\BAI\Desktop\自动打卡2\daka3"

# 添加所有文件
git add .

# 提交更改
git commit -m "feat: 添加 GitHub Actions 自动构建配置"

# 推送到 GitHub（这会触发自动构建）
git push origin main
```

### 步骤 2：查看构建进度

1. 访问你的 GitHub 仓库：https://github.com/baibiao258/dakajingxiang
2. 点击 **"Actions"** 标签
3. 查看最新的 workflow 运行状态
4. 等待构建完成（约 5-10 分钟）

### 步骤 3：设置镜像为公开（重要！）

默认情况下，ghcr.io 的镜像是私有的。如果 Leaflow 无法访问私有镜像，需要将其设置为公开：

1. 访问：https://github.com/baibiao258/dakajingxiang/pkgs/container/dakajingxiang
2. 点击右侧 **"Package settings"**
3. 滚动到底部，找到 **"Change visibility"**
4. 选择 **"Public"**
5. 确认更改

### 步骤 4：在 Leaflow 部署

#### 镜像地址
```
ghcr.io/baibiao258/dakajingxiang:latest
```

#### 环境变量配置
| 变量名 | 值 | 说明 |
|--------|-----|------|
| `CHECKIN_USERNAME` | 你的用户名 | 登录账号 |
| `CHECKIN_PASSWORD` | 你的密码 | 登录密码 |
| `GITHUB_ACTIONS` | `true` | ⚠️ 必须，强制无头模式 |

#### 资源限制
- **CPU**：`500m` ~ `1000m`
- **Memory**：`1024 MiB`（⚠️ 至少 1GB）

---

## ⏰ 定时任务

容器启动后会自动执行：

| 时间 | 任务 | 脚本 |
|------|------|------|
| 🔔 08:00 | 自动打卡 | `auto_checkin.py` |
| 🔔 17:00 | 自动打卡 | `auto_checkin.py` |
| 📝 19:00 | 自动日报 | `auto_daily_report.py` |

**时区**：`Asia/Shanghai`（北京时间）

---

## 🔧 手动触发构建

如果需要手动重新构建镜像：

1. 访问：https://github.com/baibiao258/dakajingxiang/actions
2. 点击左侧 **"Build and Push Docker Image"**
3. 点击右侧 **"Run workflow"**
4. 选择 `main` 分支
5. 点击绿色的 **"Run workflow"** 按钮

---

## 🛠️ 故障排查

### ❌ GitHub Actions 构建失败
**检查**：
1. 查看 Actions 标签页的错误日志
2. 确认 `Dockerfile` 和 `requirements.txt` 语法正确
3. 检查是否有网络问题（重新运行 workflow）

### ❌ Leaflow 无法拉取镜像
**原因**：镜像可能是私有的  
**解决**：
1. 将 ghcr.io 镜像设置为 **Public**（见上面步骤 3）
2. 或者在 Leaflow 配置私有仓库凭据

### ❌ 容器启动后立即退出
**检查**：
- 确保环境变量 `CHECKIN_USERNAME` 和 `CHECKIN_PASSWORD` 已设置
- 查看 Leaflow 日志输出

### ❌ 内存不足（OOM）
**解决**：将内存限制提升至 **1024 MiB** 或更高

---

## 📖 工作原理

1. **推送代码到 GitHub** → 触发 GitHub Actions
2. **GitHub Actions 构建镜像** → 自动运行 Dockerfile
3. **推送到 ghcr.io** → 镜像存储在 GitHub Container Registry
4. **Leaflow 拉取镜像** → 从 ghcr.io 获取最新镜像
5. **容器启动** → 运行 `main.py`，开始定时任务

---

## 🎉 优势

✅ **自动化**：每次代码更新自动构建新镜像  
✅ **版本控制**：每个提交都有对应的镜像标签  
✅ **免费**：GitHub Container Registry 对公开镜像免费  
✅ **方便**：无需本地安装 Docker  
✅ **可追溯**：在 Actions 中查看每次构建日志

---

## 📞 需要帮助？

遇到问题？请检查：
1. 📋 GitHub Actions 日志
2. 📋 Leaflow 容器日志
3. 📖 本项目的其他文档（`DEPLOY.md`, `QUICKSTART.md`）

---

**祝你部署成功！** 🚀
