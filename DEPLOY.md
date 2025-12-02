# 🚀 Leaflow 容器化部署指南

## 📋 前置条件

1. **Docker** 已安装
2. **Leaflow 账号** 已创建
3. **环境变量准备**：
   - `CHECKIN_USERNAME`：你的用户名
   - `CHECKIN_PASSWORD`：你的密码

---

## 🔨 步骤 1: 构建 Docker 镜像

在项目根目录（包含 `Dockerfile` 的目录）执行：

```bash
# 构建镜像（替换 your-username 为你的 Docker Hub 用户名）
docker build -t your-username/leaflow-auto-checkin:latest .

# 如果你使用阿里云容器镜像服务
docker build -t registry.cn-hangzhou.aliyuncs.com/your-namespace/leaflow-auto-checkin:latest .
```

**注意**：镜像构建可能需要 5-10 分钟，因为需要下载 Playwright 镜像（约 2GB）。

---

## 📤 步骤 2: 推送镜像到镜像仓库

### 选项 A: 使用 Docker Hub

```bash
# 登录 Docker Hub
docker login

# 推送镜像
docker push your-username/leaflow-auto-checkin:latest
```

### 选项 B: 使用阿里云容器镜像服务（推荐国内用户）

```bash
# 登录阿里云容器镜像服务
docker login --username=your-aliyun-account registry.cn-hangzhou.aliyuncs.com

# 推送镜像
docker push registry.cn-hangzhou.aliyuncs.com/your-namespace/leaflow-auto-checkin:latest
```

---

## 🌐 步骤 3: 在 Leaflow 平台创建应用

### 3.1 登录 Leaflow 平台

访问 Leaflow 控制台并登录。

### 3.2 创建新应用

1. 点击 **"创建应用"** 或 **"新建应用"**
2. 选择 **"容器部署"** 或 **"自定义镜像"**

### 3.3 配置应用信息

#### 基本信息
- **应用名称**：`auto-checkin`（或自定义）
- **镜像地址**：
  ```
  your-username/leaflow-auto-checkin:latest
  ```
  或
  ```
  registry.cn-hangzhou.aliyuncs.com/your-namespace/leaflow-auto-checkin:latest
  ```

#### 资源配置（重要！）
- **CPU**：`500m` - `1000m`（毫核）
- **内存**：`1024 MiB`（1GB）⚠️ **必须至少 1GB**，Playwright 启动 Chromium 非常消耗内存

#### 环境变量配置
添加以下环境变量：

| 变量名 | 值 | 说明 |
|--------|-----|------|
| `CHECKIN_USERNAME` | 你的用户名 | 登录用户名 |
| `CHECKIN_PASSWORD` | 你的密码 | 登录密码 |
| `GITHUB_ACTIONS` | `true` | 强制无头模式 |
| `TZ` | `Asia/Shanghai` | 时区（可选） |

**⚠️ 重要提示**：
- 确保 `GITHUB_ACTIONS=true`，否则容器中会因为无界面而报错
- 密码等敏感信息建议使用 Leaflow 的 **密钥管理** 功能

#### 持久化存储（可选）
如果需要保存日志文件，可以配置：
- **挂载路径**：`/app`
- **存储卷大小**：`1GB`

---

## ⏰ 步骤 4: 验证定时任务

应用部署成功后，定时任务会自动运行：
- ✅ **每天 08:00** - 自动打卡
- ✅ **每天 17:00** - 自动打卡
- ✅ **每天 19:00** - 自动日报

### 查看日志

在 Leaflow 控制台：
1. 进入应用详情页
2. 点击 **"日志"** 或 **"查看日志"**
3. 查看容器输出，确认定时任务是否正常执行

你应该能看到类似输出：
```
🚀 Leaflow 自动化容器启动
启动时间: 2024-12-02 23:10:00
时区: ('CST', 'CST')
用户名: your-username

📅 配置定时任务:
  ✓ 任务 A: 每天 08:00 和 17:00 执行自动打卡
  ✓ 任务 B: 每天 19:00 执行自动日报

✅ 定时任务配置完成，容器将保持常驻运行
⏰ 开始监听定时任务...
```

---

## 🧪 本地测试（可选）

在部署到 Leaflow 之前，建议先在本地测试：

```bash
# 构建镜像
docker build -t auto-checkin:test .

# 运行容器
docker run -d \
  --name auto-checkin-test \
  -e CHECKIN_USERNAME="your-username" \
  -e CHECKIN_PASSWORD="your-password" \
  -e GITHUB_ACTIONS=true \
  auto-checkin:test

# 查看日志
docker logs -f auto-checkin-test

# 停止并删除容器
docker stop auto-checkin-test
docker rm auto-checkin-test
```

---

## 🛠️ 故障排查

### 1. 容器启动后立即退出
**原因**：缺少环境变量或代码错误  
**解决**：
- 检查环境变量是否正确设置
- 查看日志输出

### 2. 内存不足（OOM Killed）
**原因**：内存限制太低  
**解决**：
- 将内存限制提升至 **1024 MiB** 或更高

### 3. 时区不正确
**原因**：容器时区默认为 UTC  
**解决**：
- 已在 Dockerfile 中设置 `TZ=Asia/Shanghai`
- 如果问题仍存在，添加环境变量 `TZ=Asia/Shanghai`

### 4. 验证码识别失败
**原因**：`ddddocr` 准确率问题  
**解决**：
- 查看日志中的验证码识别结果
- 脚本已内置无限重试机制，会自动重试直到成功

---

## 📝 注意事项

1. **镜像大小**：约 2GB（包含 Playwright 和浏览器）
2. **首次启动**：可能需要 1-2 分钟初始化
3. **资源消耗**：
   - 空闲时：CPU ~50m，内存 ~200MB
   - 任务执行时：CPU ~500m，内存 ~800MB
4. **日志保留**：建议定期清理日志文件
5. **安全性**：不要在公共仓库中暴露包含密码的镜像

---

## 🎯 下一步

- ✅ 配置 **WxPusher 通知**（可选）
- ✅ 设置 **监控告警**
- ✅ 配置 **日志收集**

---

## 📞 支持

如有问题，请检查：
1. Leaflow 平台官方文档
2. 容器日志输出
3. GitHub Issues（如果项目开源）

---

**祝部署顺利！** 🎉
