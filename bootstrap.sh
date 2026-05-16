#!/usr/bin/env bash
set -euo pipefail

# 1) install dependencies
if [[ "$(uname -s)" == "Darwin" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew install age git curl
else
  sudo apt-get update && sudo apt-get install -y curl age git
fi

sh -c "$(curl -fsLS https://get.chezmoi.io)"

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
