#!/bin/bash

# Simple thresholds
DISK_THRESHOLD=5
MEM_THRESHOLD=5

echo "===== System Monitor ====="

# ----------------------------
# Disk Usage Check
# ----------------------------
disk=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

echo "Disk Usage: $disk%"

if [ $disk -gt $DISK_THRESHOLD ]; then
    echo "ALERT: Disk usage is high!"
fi

# ----------------------------
# Memory Usage Check
# ----------------------------
mem=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

echo "Memory Usage: $mem%"

if [ $mem -gt $MEM_THRESHOLD ]; then
    echo "ALERT: Memory usage is high!"
fi

# ----------------------------
# Top Processes
# ----------------------------
echo ""
echo "Top 3 CPU processes:"
ps -eo pid,cmd,%cpu --sort=-%cpu | head -4

echo ""
echo "Top 3 Memory processes:"
ps -eo pid,cmd,%mem --sort=-%mem | head -4

echo "=========================="
