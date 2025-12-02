# 使用微软官方 Playwright 镜像（包含 Python 3.10+ 和浏览器环境）
FROM mcr.microsoft.com/playwright:v1.40.0-jammy

# 设置工作目录
WORKDIR /app

# 设置时区为 Asia/Shanghai（非常重要！）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置环境变量
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖（ddddocr 需要）
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件
COPY requirements.txt .

# 升级 pip 并安装 Python 依赖（使用官方源）
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir playwright>=1.40.0 && \
    python3 -m pip install --no-cache-dir schedule requests && \
    python3 -m pip install --no-cache-dir Pillow && \
    python3 -m pip install --no-cache-dir ddddocr

# 复制项目文件
COPY . .

# 设置健康检查（可选）
HEALTHCHECK --interval=5m --timeout=3s \
    CMD test -f /app/scheduler.log || exit 1

# 容器启动时运行调度器
CMD ["python3", "main.py"]
