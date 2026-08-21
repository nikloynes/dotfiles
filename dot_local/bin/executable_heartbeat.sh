#!/data/data/com.termux/files/usr/bin/bash

LOG=~/.local/state/heartbeat.log
mkdir -p "$(dirname "$LOG")"

IP=$(ip -4 addr show wlan0 2>/dev/null | awk '/inet /{print $2}' | cut -d/ -f1)

{
  echo "$(date '+%Y-%m-%d %H:%M:%S') heartbeat OK"
  echo "IP: ${IP:-unavailable}"
} > "$LOG"