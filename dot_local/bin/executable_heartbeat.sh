#!/data/data/com.termux/files/usr/bin/bash

LOG=~/.local/state/heartbeat.log
mkdir -p "$(dirname "$LOG")"

IP=$(ifconfig 2>/dev/null | awk '/^wlan0:/{found=1} found && /inet /{print $2; exit}')

{
  echo "$(date '+%Y-%m-%d %H:%M:%S') heartbeat OK"
  echo "IP: ${IP:-unavailable}"
} > "$LOG"