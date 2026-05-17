#!/usr/bin/env bash

is_raspberry_pi() {
  grep -qi 'raspberry pi' /proc/device-tree/model 2>/dev/null || \
  grep -qi 'raspbian\|raspberry' /etc/os-release 2>/dev/null
}
