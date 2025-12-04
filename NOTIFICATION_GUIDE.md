# 📱 通知功能配置指南

## ✅ 现有通知功能

### 🔔 WxPusher 通知（已实现）

**当前系统内置了WxPusher通知功能**，当打卡和日报任务执行时会自动发送微信通知：

#### 📋 支持的通知事件
- ✅ **自动打卡成功** - 每天08:00、17:00
- ✅ **自动打卡失败** - 执行出错时
- ✅ **自动日报成功** - 每天19:00
- ✅ **自动日报失败** - 执行出错时

#### 🔑 需要配置的环境变量
| 变量名 | 说明 | 获取方式 |
|--------|------|----------|
| `WXPUSHER_APP_TOKEN` | WxPusher应用Token | 微信关注"WxPusher"公众号获取 |
| `WXPUSHER_UID` | WxPusher用户UID | 在WxPusher中获取你的UID |

---

## 🚀 WxPusher配置步骤

### 步骤1: 获取WxPusher凭据
1. **微信搜索并关注"WxPusher"公众号**
2. **发送"开始"获取Token**
3. **获取你的UID**

### 步骤2: 在Leaflow中添加环境变量
在Leaflow应用的环境变量中添加：

```
WXPUSHER_APP_TOKEN=你的Token
WXPUSHER_UID=你的UID
```

### 步骤3: 验证通知功能
- 下次打卡或日报执行时会收到微信通知
- 成功和失败都会发送通知

---

## ❓ Weshuper通知功能

**目前系统没有集成Weshuper通知功能**。

### 🤔 是否需要添加Weshuper通知？

如果你希望使用Weshuper通知，我可以为你：

1. **添加Weshuper通知支持**
2. **支持多种通知方式同时配置**
3. **提供Weshuper配置指南**

### 💬 请告诉我你的偏好

你更倾向于：
- **A**: 保留现有的WxPusher通知功能
- **B**: 替换为Weshuper通知功能  
- **C**: 同时支持WxPusher和Weshuper通知

---

## 📋 当前完整环境变量列表

### 必需变量
- `CHECKIN_USERNAME` - 登录用户名
- `CHECKIN_PASSWORD` - 登录密码
- `GITHUB_ACTIONS` - `true`

### 可选通知变量
- `WXPUSHER_APP_TOKEN` - WxPusher通知（推荐启用）
- `WXPUSHER_UID` - WxPusher用户ID
- `WXPUSHER_APP_TOKEN` - Weshuper应用Token（如需）
- `WESHUPER_UID` - Weshuper用户ID（如需）

---

## ✅ 推荐配置

为了获得最佳体验，建议配置：

1. **基础配置** - 确保打卡日报正常运行
2. **WxPusher通知** - 及时接收执行结果通知
3. **定期检查** - 在Leaflow中查看详细日志

---

**需要添加Weshuper通知功能吗？请告诉我你的选择！**