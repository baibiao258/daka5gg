# 💻 本地测试打卡功能指南

## ✅ 可以本地测试！

**你的自动打卡功能完全支持本地测试**，这样可以在部署前验证功能是否正常。

---

## 📋 本地测试步骤

### 步骤 1️⃣: 环境准备

#### 检查Python版本
```bash
python --version
# 需要 Python 3.8 或更高版本
```

#### 安装Git
确保已安装Git用于下载项目

### 步骤 2️⃣: 获取项目代码

**从GitHub下载**:
```bash
git clone https://github.com/baibiao258/daka5gg.git
cd daka5gg
```

### 步骤 3️⃣: 安装依赖

#### 安装Python包
```bash
pip install -r requirements.txt
```

#### 安装Playwright浏览器
```bash
playwright install chromium
playwright install-deps chromium
```

### 步骤 4️⃣: 配置本地环境

#### 复制配置文件
```bash
cp config.json.example config.json
```

#### 编辑配置文件
编辑 `config.json` 文件：
```json
{
  "username": "你的用户名",
  "password": "你的密码",
  "wxpusher_app_token": "你的wxpushertoken",
  "wxpusher_uid": "你的uid"
}
```

### 步骤 5️⃣: 本地测试

#### 测试打卡功能
```bash
python auto_checkin.py
```

#### 测试日报功能
```bash
python auto_daily_report.py
```

#### 测试完整调度器
```bash
python main.py
```

---

## 🔍 测试预期结果

### ✅ 成功测试的标志

**打卡测试成功时**：
```
INFO - 开始执行自动打卡
INFO - 正在启动浏览器...
INFO - 已填写用户名: 你的用户名
INFO - 验证码识别结果: 1234
INFO - 已点击'提交打卡'按钮
INFO - ✅ 自动打卡完成！
```

**日志说明**：
- 浏览器自动打开登录页面
- 自动填写用户名和密码
- 识别并填写验证码
- 执行打卡操作
- 显示成功或失败结果

### 📸 调试信息

测试过程中会自动生成调试文件：
- `captcha.png` - 验证码截图
- `page_*.png` - 各步骤页面截图
- `checkin.log` - 详细日志文件

---

## 🛠️ 故障排查

### ❌ 依赖安装问题

**问题**: pip安装失败
```bash
# 尝试升级pip
python -m pip install --upgrade pip

# 使用国内镜像源
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
```

**问题**: Playwright安装失败
```bash
# Ubuntu/Debian系统
sudo apt-get update
sudo apt-get install -y libgl1-mesa-glx libglib2.0-0

# 或者使用管理员权限
sudo playwright install chromium
```

### ❌ 浏览器启动失败

**问题**: 权限不足
```bash
# Linux/Mac系统，可能需要安装依赖
sudo playwright install-deps chromium
```

**问题**: 防火墙阻止
- 确保系统防火墙允许程序访问网络
- 关闭可能冲突的VPN或代理软件

### ❌ 验证码识别失败

**解决方案**:
1. **查看生成的验证码图片** (`captcha.png`)
2. **手动验证识别结果是否正确**
3. **如果识别错误，可以手动修改代码中的验证码**

**手动修改验证码测试**:
```python
# 在auto_checkin.py中临时跳过验证码识别
captcha_text = "1234"  # 手动输入验证码
```

### ❌ 登录失败

**检查项目**:
1. **用户名密码是否正确**
2. **网站是否可访问** (`https://qd.dxssxdk.com`)
3. **网络连接是否正常**

**测试网站访问**:
```bash
curl -I https://qd.dxssxdk.com/lanhu_yonghudenglu
```

---

## 📱 通知功能测试

### 配置WxPusher通知
如果配置了WxPusher环境变量，测试时会发送通知：
- 成功时: "自动打卡成功" 
- 失败时: "自动打卡失败"

### 测试通知
可以在 `config.json` 中配置:
```json
{
  "wxpusher_app_token": "你的token",
  "wxpusher_uid": "你的uid"
}
```

---

## 🔄 完整测试流程

### 推荐测试顺序
1. **环境检查** - 确认所有依赖安装
2. **基础测试** - 运行 `python auto_checkin.py`
3. **功能验证** - 检查日志和截图
4. **错误处理** - 测试各种异常情况
5. **通知测试** - 验证通知功能

### 完整测试命令
```bash
# 1. 清理旧日志
rm -f *.log *.png *.html

# 2. 测试打卡功能
python auto_checkin.py

# 3. 测试日报功能  
python auto_daily_report.py

# 4. 查看生成的文件
ls -la *.log *.png

# 5. 查看日志
cat checkin.log
```

---

## 📊 测试结果分析

### 成功指标
- ✅ 浏览器正常启动和操作
- ✅ 成功识别并填写验证码
- ✅ 完成登录和打卡操作
- ✅ 生成相应的调试文件
- ✅ 日志显示成功完成

### 常见问题及解决
1. **浏览器无法启动** → 检查Playwright安装和系统依赖
2. **验证码识别失败** → 手动验证识别结果，调整OCR设置
3. **登录失败** → 检查用户名密码和网络连接
4. **页面元素找不到** → 网站结构可能有变化，需要更新选择器

---

## 💡 测试技巧

### 🔍 调试技巧
1. **启用详细日志**: 修改代码中的日志级别
2. **保留截图**: 查看 `page_*.png` 了解执行过程
3. **查看HTML源码**: 检查 `page_content.html` 分析页面结构
4. **分步测试**: 可以注释掉部分代码，单独测试某些功能

### 🧪 单元测试建议
- 测试验证码识别功能
- 测试登录页面元素定位
- 测试打卡按钮点击
- 测试异常情况处理

---

## ✅ 本地测试总结

**本地测试的优势**:
- 🚀 快速验证功能是否正常
- 🔧 方便调试和排错
- 💰 无需额外的云服务费用
- 🔒 保护隐私数据

**适合场景**:
- 功能验证和调试
- 定制化修改
- 性能测试
- 学习项目运行原理

**部署前必做**:
本地测试成功后，再部署到Leaflow或其他云平台，确保功能正常。

---

**现在就可以开始本地测试你的打卡功能了！** 🎉