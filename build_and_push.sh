#!/bin/bash

echo "========================================"
echo "  Docker 镜像构建和推送脚本"
echo "========================================"
echo ""

# 设置变量
IMAGE_NAME="auto-checkin"
IMAGE_TAG="latest"

# 询问用户选择镜像仓库
echo "请选择镜像仓库："
echo "1. Docker Hub"
echo "2. 阿里云容器镜像服务"
echo ""
read -p "请输入选项 (1 或 2): " REGISTRY_CHOICE

if [ "$REGISTRY_CHOICE" == "1" ]; then
    read -p "请输入 Docker Hub 用户名: " DOCKER_USERNAME
    IMAGE_FULL_NAME="$DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG"
    REGISTRY_TYPE="dockerhub"
elif [ "$REGISTRY_CHOICE" == "2" ]; then
    read -p "请输入阿里云命名空间: " ALIYUN_NAMESPACE
    IMAGE_FULL_NAME="registry.cn-hangzhou.aliyuncs.com/$ALIYUN_NAMESPACE/$IMAGE_NAME:$IMAGE_TAG"
    REGISTRY_TYPE="aliyun"
else
    echo "无效的选项！"
    exit 1
fi

echo ""
echo "========================================"
echo "  开始构建镜像"
echo "========================================"
echo "镜像名称: $IMAGE_FULL_NAME"
echo ""

docker build -t "$IMAGE_FULL_NAME" .

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 镜像构建失败！"
    exit 1
fi

echo ""
echo "✅ 镜像构建成功！"
echo ""

# 询问是否推送
read -p "是否推送到远程仓库？(y/n): " PUSH_CONFIRM
if [ "$PUSH_CONFIRM" != "y" ] && [ "$PUSH_CONFIRM" != "Y" ]; then
    echo "已取消推送"
    exit 0
fi

echo ""
echo "========================================"
echo "  登录镜像仓库"
echo "========================================"
echo ""

if [ "$REGISTRY_TYPE" == "dockerhub" ]; then
    docker login
else
    read -p "请输入阿里云账号: " ALIYUN_USERNAME
    docker login --username="$ALIYUN_USERNAME" registry.cn-hangzhou.aliyuncs.com
fi

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 登录失败！"
    exit 1
fi

echo ""
echo "========================================"
echo "  推送镜像"
echo "========================================"
echo ""

docker push "$IMAGE_FULL_NAME"

if [ $? -ne 0 ]; then
    echo ""
    echo "❌ 推送失败！"
    exit 1
fi

echo ""
echo "========================================"
echo "  ✅ 部署完成！"
echo "========================================"
echo ""
echo "镜像地址: $IMAGE_FULL_NAME"
echo ""
echo "下一步："
echo "1. 登录 Leaflow 平台"
echo "2. 创建新应用，使用上面的镜像地址"
echo "3. 配置环境变量："
echo "   - CHECKIN_USERNAME"
echo "   - CHECKIN_PASSWORD"
echo "   - GITHUB_ACTIONS=true"
echo "4. 设置资源限制："
echo "   - CPU: 500m-1000m"
echo "   - Memory: 1024 MiB"
echo ""
