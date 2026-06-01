#!/usr/bin/env bash
set -euo pipefail

# 1) install dependencies
if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    echo "OS: MacOS"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install age git curl
elif [[ "$(uname -s)" == "Linux" ]]; then
  if command -v pkg >/dev/null 2>&1 || [[ "${PREFIX:-}" == *"com.termux"* ]]; then
    echo "OS: Termux (Android)"
    pkg update -y && pkg install -y curl age git
  elif command -v apt >/dev/null 2>&1 || ! [[ "${PREFIX:-}" == *"com.termux"* ]]; then
    echo "OS: Ubuntu/Debian"
    sudo apt update && sudo apt install -y curl age git
  elif grep -qi '^ID=steamos' /etc/os-release 2>/dev/null; then
    echo "OS: Steam OS"
    pacman -S curl age git
  fi
else
  echo "Unsupported OS: $(uname -s)"
  exit 1
fi

if ! [[ "${PREFIX:-}" == *"com.termux"* ]]; then
  sh -c "$(curl -fsLS https://get.chezmoi.io)"
elif command -v pkg >/dev/null 2>&1 || [[ "${PREFIX:-}" == *"com.termux"* ]]; then
  pkg install chezmoi
fi


export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# 2) create chezmoi config dir
mkdir -p ~/.config/chezmoi

# 3) prompt to paste age private key
if [[ -f ~/.config/chezmoi/key.txt ]]; then
  echo "age key already exists, skipping"
else
  echo ""
  echo "Paste your age private key (AGE-SECRET-KEY-...), then press Ctrl+D:"
  cat >~/.config/chezmoi/key.txt
  chmod 600 ~/.config/chezmoi/key.txt
fi

# 4) init and apply via HTTPS (public repo, no auth needed)
# run_once_00 will generate the GitHub SSH key after clone
chezmoi init --apply https://github.com/nikloynes/dotfiles.git
