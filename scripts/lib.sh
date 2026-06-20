#!/usr/bin/env bash

is_raspberry_pi() {
  grep -qi 'raspberry pi' /proc/device-tree/model 2>/dev/null || \
  grep -qi 'raspbian\|raspberry' /etc/os-release 2>/dev/null
}

detect_arch() {
  case "$(uname -m)" in
    x86_64) echo "amd64" ;;
    aarch64|arm64) echo "arm64" ;;
    armv7l|armv8l) echo "armhf" ;;
    *)
      echo "Unsupported architecture: $(uname -m)" >&2
      return 1
      ;;
  esac
}