#!/bin/bash

# Server Performance Stats Script
# Author: hssnhlim
# Date: 24/12/2024

# Total CPU Usage
echo -e "\nTotal CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | xargs printf "%.2f%%\n"

# Total Memory Usage
echo -e "\nTotal Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB\n", $3, $3*100/$2, $4}'

# Total Disk Usage
echo -e "\nTotal Disk Usage:"
df -h --total | awk 'END{printf "Used: %s, Free: %s, Usage: %s\n", $3, $4, $5}'

# Top 5 Processes by CPU Usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Processes by Memory Usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Stretch Goals
echo -e "\nAdditional Stats:"

# OS Version
echo -e "\nOS Version:"
lsb_release -a 2>/dev/null || cat /etc/os-release

# System Uptime
echo -e "\nSystem Uptime:"
uptime -p

# Load Average
echo -e "\nLoad Average:"
uptime | awk -F'load average:' '{ print $2 }'

# Logged-in Users
echo -e "\nLogged-in Users:"
who

# Failed Login Attempts
echo -e "\nFailed Login Attempts:"
grep "Failed password" /var/log/auth.log | wc -l
