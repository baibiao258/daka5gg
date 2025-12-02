# 🎯 快速开始 - Leaflow 容器化部署

## ✅ 已生成的文件

```
📁 项目根目录
├── 📄 requirements.txt        # Python 依赖（已补全）
├── 📄 main.py                 # 调度器入口（新建）
├── 📄 Dockerfile              # Docker 镜像配置（新建）
├── 📄 .dockerignore           # Docker 忽略文件（新建）
├── 📄 DEPLOY.md               # 详细部署指南（新建）
├── 📄 build_and_push.bat      # Windows 构建脚本（新建）
├── 📄 build_and_push.sh       # Linux/Mac 构建脚本（新建）
├── 📄 auto_checkin.py         # 自动打卡脚本（已存在）
└── 📄 auto_daily_report.py    # 自动日报脚本（已存在）
```

---

## 🚀 三步完成部署

### 步骤 1️⃣：构建并推送 Docker 镜像

#### Windows 用户：
```cmd
# 双击运行或在命令行执行
build_and_push.bat
```

#### Linux/Mac 用户：
```bash
# 添加执行权限
chmod +x build_and_push.sh

# 运行脚本
./build_and_push.sh
```

脚本会自动：
- ✅ 构建 Docker 镜像
- ✅ 登录镜像仓库（Docker Hub 或阿里云）
- ✅ 推送镜像到远程仓库

**📝 注意**：首次构建需要下载约 2GB 的 Playwright 镜像，请耐心等待。

---

### 步骤 2️⃣：在 Leaflow 创建应用

1. **登录 Leaflow 平台**
2. **创建新应用** → 选择"容器部署"
3. **填写镜像地址**：复制脚本输出的镜像地址

---

### 步骤 3️⃣：配置环境变量和资源

#### 必需的环境变量：
| 变量名 | 值 | 说明 |
|--------|-----|------|
| `CHECKIN_USERNAME` | 你的用户名 | 登录账号 |
| `CHECKIN_PASSWORD` | 你的密码 | 登录密码 |
| `GITHUB_ACTIONS` | `true` | ⚠️ 必须设置，强制无头模式 |

#### 资源限制（重要！）：
- **CPU**：`500m` ~ `1000m`
- **内存**：`1024 MiB`（最少 1GB）⚠️ **不能低于 1GB**

---

## ⏰ 定时任务说明

容器启动后，会自动执行以下定时任务：

| 任务 | 执行时间 | 脚本 |
|------|----------|------|
| 🔔 自动打卡 | 每天 **08:00** | `auto_checkin.py` |
| 🔔 自动打卡 | 每天 **17:00** | `auto_checkin.py` |
| 📝 自动日报 | 每天 **19:00** | `auto_daily_report.py` |

**时区**：`Asia/Shanghai`（北京时间）

---

## 🛠️ 故障排查

### ❌ 容器启动后立即退出
**解决**：检查环境变量 `CHECKIN_USERNAME` 和 `CHECKIN_PASSWORD` 是否正确设置

### ❌ 内存不足（OOM）
**解决**：将内存限制提升至 **1024 MiB** 或更高

### ❌ 时区不对
**解决**：已在 Dockerfile 中配置 `TZ=Asia/Shanghai`，无需额外设置

### ❌ 验证码识别失败
**解决**：脚本已内置无限重试机制，会自动重试直到成功

---

## 📖 详细文档

如需更详细的部署说明（包括手动构建、本地测试等），请查看：

👉 **[DEPLOY.md](./DEPLOY.md)** - 完整部署指南

---

## 🎉 部署成功！

一切配置完成后，你的应用将：
- ✅ 常驻运行在容器中
- ✅ 自动在指定时间执行打卡和日报
- ✅ 出错后自动重试
- ✅ 记录详细日志

**查看日志**：在 Leaflow 控制台 → 应用详情 → 日志

---

## 📞 需要帮助？

遇到问题？请检查：
1. 📋 容器日志输出
2. 📖 [DEPLOY.md](./DEPLOY.md) 完整部署指南
3. 🔧 Leaflow 平台官方文档

---

**祝你使用愉快！** 🚀
