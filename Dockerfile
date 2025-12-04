# 使用微软官方的 Playwright 镜像
FROM mcr.microsoft.com/playwright:v1.40.0-jammy

# 设置工作目录
WORKDIR /app

# 设置时区为上海
RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && echo Asia/Shanghai > /etc/timezone

# 1. 安装系统依赖 (关键：增加了 python3-pip)
RUN apt-get update && apt-get install -y \
    python3-pip \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 2. 复制依赖文件
COPY requirements.txt .

# 3. 安装 Python 依赖
# 关键：增加了 --break-system-packages 以解决 Ubuntu 22.04+ 的限制
RUN python3 -m pip install --no-cache-dir --upgrade pip --break-system-packages && \
    python3 -m pip install --no-cache-dir -r requirements.txt --break-system-packages

# 4. 复制项目所有代码
COPY . .

# 启动命令
CMD ["python3", "main.py"]
