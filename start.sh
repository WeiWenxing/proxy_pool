#!/usr/bin/env bash

# Kill existing processes
pkill -f "python proxyPool.py server"
pkill -f "python proxyPool.py schedule"

# Wait a moment to ensure processes are killed
sleep 1

# Start services with nohup
nohup python proxyPool.py server > /tmp/proxy-server.log 2>&1 &
nohup python proxyPool.py schedule > /tmp/proxy-schedule.log 2>&1 &

echo "Services started. Check logs at:"
echo "  Server log: /tmp/proxy-server.log"
echo "  Schedule log: /tmp/proxy-schedule.log"
