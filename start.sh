#!/usr/bin/env bash

# 激活虚拟环境
echo "Activating virtual environment..."
source venv/bin/activate

# 检查虚拟环境是否成功激活
if [ $? -ne 0 ]; then
    echo "Failed to activate virtual environment. Please check if venv exists."
    exit 1
fi

# 再次验证Python环境
PYTHON_PATH=$(which python)
if [[ $PYTHON_PATH != *"venv"* ]]; then
    echo "Virtual environment is not properly activated. Current Python: $PYTHON_PATH"
    exit 1
fi

echo "Virtual environment activated successfully. Using Python: $PYTHON_PATH"

# Kill existing processes
echo "Stopping existing services..."
pkill -f "python proxyPool.py server"
pkill -f "python proxyPool.py schedule"

# Wait a moment to ensure processes are killed
sleep 1

# Start services with nohup
echo "Starting services..."
nohup python proxyPool.py server > /tmp/proxy-server.log 2>&1 &
nohup python proxyPool.py schedule > /tmp/proxy-schedule.log 2>&1 &

echo "Services started. Check logs at:"
echo "  Server log: /tmp/proxy-server.log"
echo "  Schedule log: /tmp/proxy-schedule.log"

