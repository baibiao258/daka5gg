@echo off
chcp 65001 >nul
echo ========================================
echo   Docker 镜像构建和推送脚本
echo ========================================
echo.

REM 设置变量
set IMAGE_NAME=auto-checkin
set IMAGE_TAG=latest

REM 询问用户选择镜像仓库
echo 请选择镜像仓库：
echo 1. Docker Hub
echo 2. 阿里云容器镜像服务
echo.
set /p REGISTRY_CHOICE="请输入选项 (1 或 2): "

if "%REGISTRY_CHOICE%"=="1" (
    set /p DOCKER_USERNAME="请输入 Docker Hub 用户名: "
    set IMAGE_FULL_NAME=%DOCKER_USERNAME%/%IMAGE_NAME%:%IMAGE_TAG%
    set REGISTRY_TYPE=dockerhub
) else if "%REGISTRY_CHOICE%"=="2" (
    set /p ALIYUN_NAMESPACE="请输入阿里云命名空间: "
    set IMAGE_FULL_NAME=registry.cn-hangzhou.aliyuncs.com/%ALIYUN_NAMESPACE%/%IMAGE_NAME%:%IMAGE_TAG%
    set REGISTRY_TYPE=aliyun
) else (
    echo 无效的选项！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   开始构建镜像
echo ========================================
echo 镜像名称: %IMAGE_FULL_NAME%
echo.

docker build -t %IMAGE_FULL_NAME% .

if %errorlevel% neq 0 (
    echo.
    echo ❌ 镜像构建失败！
    pause
    exit /b 1
)

echo.
echo ✅ 镜像构建成功！
echo.

REM 询问是否推送
set /p PUSH_CONFIRM="是否推送到远程仓库？(Y/N): "
if /i not "%PUSH_CONFIRM%"=="Y" (
    echo 已取消推送
    pause
    exit /b 0
)

echo.
echo ========================================
echo   登录镜像仓库
echo ========================================
echo.

if "%REGISTRY_TYPE%"=="dockerhub" (
    docker login
) else (
    set /p ALIYUN_USERNAME="请输入阿里云账号: "
    docker login --username=%ALIYUN_USERNAME% registry.cn-hangzhou.aliyuncs.com
)

if %errorlevel% neq 0 (
    echo.
    echo ❌ 登录失败！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   推送镜像
echo ========================================
echo.

docker push %IMAGE_FULL_NAME%

if %errorlevel% neq 0 (
    echo.
    echo ❌ 推送失败！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✅ 部署完成！
echo ========================================
echo.
echo 镜像地址: %IMAGE_FULL_NAME%
echo.
echo 下一步：
echo 1. 登录 Leaflow 平台
echo 2. 创建新应用，使用上面的镜像地址
echo 3. 配置环境变量：
echo    - CHECKIN_USERNAME
echo    - CHECKIN_PASSWORD
echo    - GITHUB_ACTIONS=true
echo 4. 设置资源限制：
echo    - CPU: 500m-1000m
echo    - Memory: 1024 MiB
echo.
pause
