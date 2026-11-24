#!/bin/bash

# Taskflow Cloud Platform
# Development server health check

PROJECT_NAME="Taskflow"
ENVIRONMENT="Development"
DISK_THRESHOLD=80
SERVICE_NAME="ssh"

# Detect failures within pipelines
set -o pipefail

# Collect server information

SERVER_NAME=$(hostname)
CURRENT_DATE=$(date)
CURRENT_UPTIME=$(uptime -p)

echo "=============================="
echo "      $PROJECT_NAME System Health Check"
echo "=============================="
echo "Environment: $ENVIRONMENT"
echo "Server: $SERVER_NAME"
echo "Date: $CURRENT_DATE"
echo "Uptime: $CURRENT_UPTIME"

# Memory  Usage
echo ""
echo "=== Memory Usage ==="
free -h

# Disk Usage
echo ""
echo "=== Disk Usage ==="
df -h /

# Retrieve and evaluate actual disk usage

echo ""
if DISK_USAGE=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%'); then
	if [[ ! "$DISK_USAGE" =~ ^[0-9]+$ ]]; then
		echo "ERROR: Invalid disk usage value"
	elif [[ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]]; then
		echo "WARNING: High disk usage ($DISK_USAGE%)"	
	else
		echo "OK: Disk usage is normal ($DISK_USAGE%)"
	fi
else
	echo "ERROR: Unable to retrieve disk usage"
fi

# SSH Service Status
echo ""
echo "=== Service Status ==="

if systemctl is-active --quiet "$SERVICE_NAME"; then
	echo "OK: $SERVICE_NAME service is active"
else
	echo "WARNING: $SERVICE_NAME service is not active"
fi

echo ""
echo "=============================="
echo "      END OF HEALTH CHECK"
echo "=============================="
