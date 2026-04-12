#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════════
#  zsh-setup.sh — Itachi's Zsh Plugin & Tool Setup Script
#  Run once after copying the config files
# ══════════════════════════════════════════════════════════════════

set -e
PLUGIN_DIR="$HOME/.zsh_plugins"
mkdir -p "$PLUGIN_DIR"
mkdir -p "$HOME/.zsh/cache"
mkdir -p "$HOME/.config"

echo "══════════════════════════════════════════"
echo " Zsh Plugin & Tool Setup"
echo "══════════════════════════════════════════"

# ── Function: clone or pull ───────────────────────────────────────
install_plugin() {
  local name="$1"
  local url="$2"
  local dir="$PLUGIN_DIR/$name"
  if [[ -d "$dir" ]]; then
    echo "  [↻] Updating $name..."
    git -C "$dir" pull --quiet
  else
    echo "  [+] Installing $name..."
    git clone --depth=1 "$url" "$dir"
  fi
}

# ── Essential Zsh Plugins ─────────────────────────────────────────
echo ""
echo "→ Installing Zsh plugins..."
install_plugin zsh-syntax-highlighting \
  https://github.com/zsh-users/zsh-syntax-highlighting

install_plugin zsh-autosuggestions \
  https://github.com/zsh-users/zsh-autosuggestions

install_plugin zsh-history-substring-search \
  https://github.com/zsh-users/zsh-history-substring-search

install_plugin zsh-completions \
  https://github.com/zsh-users/zsh-completions

# ── Optional: Install CLI tools via zypper ────────────────────────
echo ""
echo "→ Checking CLI tools (requires sudo)..."

install_if_missing() {
  local cmd="$1"
  local pkg="${2:-$1}"
  if ! command -v "$cmd" &>/dev/null; then
    echo "  [+] Installing $pkg..."
    sudo zypper install -y "$pkg" 2>/dev/null || echo "  [!] Could not install $pkg — install manually"
  else
    echo "  [✓] $cmd already installed"
  fi
}

install_if_missing fzf
install_if_missing bat
install_if_missing eza
install_if_missing fd  "fd"
install_if_missing zoxide
install_if_missing starship
install_if_missing atuin

# ── Copy config files ─────────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "→ Copying config files..."

if [[ -f "$SCRIPT_DIR/zshrc" ]]; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d)" 2>/dev/null && echo "  [✓] Backed up old .zshrc"
  cp "$SCRIPT_DIR/zshrc" "$HOME/.zshrc"
  echo "  [✓] .zshrc installed"
fi

if [[ -f "$SCRIPT_DIR/starship.toml" ]]; then
  mkdir -p "$HOME/.config"
  cp "$SCRIPT_DIR/starship.toml" "$HOME/.config/starship.toml"
  echo "  [✓] starship.toml installed"
fi

echo ""
echo "══════════════════════════════════════════"
echo " Done! Run: source ~/.zshrc"
echo "══════════════════════════════════════════"
