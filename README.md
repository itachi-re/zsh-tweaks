# 🌀 zsh-tweaks

> My daily-driver Zsh + Starship setup — tuned for speed, clarity, and a bit of style. Built and battle-tested on **openSUSE Tumbleweed** with KDE Plasma 6, but portable to any modern Linux box.

<p align="center">
  <img src="https://via.placeholder.com/900x220?text=zsh-tweaks+%2B+starship" alt="zsh-tweaks banner" width="100%">
</p>

<p align="center">
  <a href="https://www.zsh.org/"><img alt="Zsh" src="https://img.shields.io/badge/shell-zsh-4EAA25?logo=gnubash&logoColor=white"></a>
  <a href="https://starship.rs/"><img alt="Starship" src="https://img.shields.io/badge/prompt-starship-DD0B78?logo=starship&logoColor=white"></a>
  <a href="https://www.opensuse.org/"><img alt="openSUSE" src="https://img.shields.io/badge/tested%20on-openSUSE%20Tumbleweed-73BA25?logo=opensuse&logoColor=white"></a>
  <img alt="Shell script" src="https://img.shields.io/github/languages/top/itachi-re/zsh-tweaks?color=4EAA25">
  <img alt="Last commit" src="https://img.shields.io/github/last-commit/itachi-re/zsh-tweaks">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <a href="https://github.com/itachi-re/zsh-tweaks/graphs/commit-activity"><img alt="Maintained" src="https://img.shields.io/badge/maintained%3F-yes-brightgreen.svg"></a>
</p>

---

## 📖 Table of Contents

- [About](#-about)
- [Features](#-features)
- [Screenshots](#️-screenshots)
- [Quick Start](#-quick-start)
- [File Structure](#-file-structure)
- [Dependencies](#-dependencies)
- [Key Aliases & Functions](#-key-aliases--functions)
- [Customization](#-customization)
- [Uninstall / Rollback](#-uninstall--rollback)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#️-roadmap)
- [Contributing](#-contributing)
- [License](#-license)
- [Acknowledgements](#-acknowledgements)

---

## 📚 About

This repo is **not a framework** — it's the actual `.zshrc` and `starship.toml` I use every day, published so it's easy for me to sync across machines and easy for anyone else to fork, strip down, and make their own.

Every alias, function, and prompt module exists for one reason: **remove friction**. No bloated plugin managers unless you want one, no mystery meat config — just a shell that starts fast and gets out of your way.

---

## ✨ Features

| | |
|---|---|
| ⚡ **Fast startup** | Lazy-loaded completions and an async Starship prompt — no noticeable lag, even on spinning rust. |
| 🎨 **Minimal, readable theme** | Calm colors, compact segments, only the info that actually matters. |
| 🧠 **Smart aliases** | Shortcuts for Git, navigation, package managers, and common typo fixes. |
| 🔍 **Better history** | Deduplicated, timestamped, and shared live across all open sessions. |
| 🛠️ **Utility functions** | One-liners for extracting any archive, making+entering dirs, quick backups, and more. |
| 📦 **Optional plugin support** | Drop-in block for `zinit` if you want plugins — fully commented out by default. |
| 🔒 **Sane, safe defaults** | No aggressive `set -e`-style footguns in an interactive shell; options are chosen deliberately, not copy-pasted. |
| 🐧 **Distro-aware** | Package-manager aliases auto-detect `zypper` / `pacman` / `apt` so the same `.zshrc` works across distros. |

---

## 🖼️ Screenshots

> Replace these placeholders with real captures of your terminal (Ghostty, Kitty, Alacritty, etc.).

| Shell startup | Starship prompt in action | Git-aware prompt |
|:---:|:---:|:---:|
| ![startup](https://via.placeholder.com/380x220?text=zsh+startup) | ![prompt](https://via.placeholder.com/380x220?text=starship+prompt) | ![git](https://via.placeholder.com/380x220?text=git+status) |

---

## 🚀 Quick Start

**1. Clone the repo**
```bash
git clone https://github.com/itachi-re/zsh-tweaks.git ~/.zsh-tweaks
```

**2. Back up anything you already have**
```bash
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup
[ -f ~/.config/starship.toml ] && mv ~/.config/starship.toml ~/.config/starship.toml.backup
```

**3. Symlink the configs**
```bash
ln -s ~/.zsh-tweaks/.zshrc ~/.zshrc
mkdir -p ~/.config
ln -s ~/.zsh-tweaks/starship.toml ~/.config/starship.toml
```

**4. Reload**
```bash
exec zsh
```

That's it. The prompt adapts automatically to Git, Node, Python, Rust, and container contexts as you `cd` into them.

<details>
<summary>💡 One-line installer (optional)</summary>

```bash
curl -fsSL https://raw.githubusercontent.com/itachi-re/zsh-tweaks/main/install.sh | zsh
```
*(Only use this if you've reviewed `install.sh` — never run scripts blind.)*
</details>

---

## 📁 File Structure

```
zsh-tweaks/
├── .zshrc              # Main entrypoint — options, env, sourcing order
├── starship.toml       # Prompt layout, modules, colors
├── aliases.zsh          # Git / package-manager / navigation shortcuts
├── functions.zsh         # extract(), mkcd(), backup(), etc.
├── install.sh           # Optional one-shot installer
└── README.md
```

> Prefer everything in one file? `.zshrc` works standalone — the split files are just sourced for readability and can be merged freely.

---

## 🧩 Dependencies

| Tool | Minimum version | Install |
|---|---|---|
| [Zsh](https://www.zsh.org/) | ≥ 5.0 | `sudo zypper in zsh` / `sudo pacman -S zsh` |
| [Starship](https://starship.rs/) | ≥ 1.0 | `curl -sS https://starship.rs/install.sh \| sh` |
| A [Nerd Font](https://www.nerdfonts.com/font-downloads) | — | Needed for prompt glyphs/icons |
| True-color terminal | — | Ghostty, Kitty, Alacritty, WezTerm all work great |

Optional, only if you enable the relevant block in `.zshrc`:
- [`zinit`](https://github.com/zdharma-continuum/zinit) — plugin manager
- [`fzf`](https://github.com/junegunn/fzf) — fuzzy history/file search
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) — smarter `cd`

---

## ⌨️ Key Aliases & Functions

A few highlights (see `aliases.zsh` / `functions.zsh` for the full list):

```zsh
# Navigation
alias ..='cd ..'
alias ...='cd ../..'

# Git
alias gs='git status -sb'
alias gc='git commit -v'
alias gp='git push'

# Package management (auto-detected)
alias update='zypper ref && zypper dup'   # openSUSE Tumbleweed
# alias update='sudo pacman -Syu'         # Arch

# Functions
mkcd() { mkdir -p "$1" && cd "$1"; }
extract() { ... }   # handles .tar.gz, .zip, .7z, .rar, etc.
```

---

## 🎛️ Customization

1. **Prompt** — edit `starship.toml`. See the [Starship config docs](https://starship.rs/config/) for every available module.
2. **Aliases** — add your own to `aliases.zsh` under the relevant section.
3. **Plugins** — uncomment the `zinit` block in `.zshrc` and list plugins there.
4. **Environment** — set `EDITOR`, `GPG_TTY`, `PATH` additions, etc. near the top of `.zshrc`.

### Example: swapping the prompt symbol

```toml
[character]
success_symbol = "[➜](bold green)"
error_symbol   = "[➜](bold red)"
```

---

## ↩️ Uninstall / Rollback

```bash
rm ~/.zshrc ~/.config/starship.toml
mv ~/.zshrc.backup ~/.zshrc 2>/dev/null
mv ~/.config/starship.toml.backup ~/.config/starship.toml 2>/dev/null
```

---

## 🩹 Troubleshooting

| Symptom | Likely fix |
|---|---|
| Prompt shows broken glyphs/boxes | Install and select a Nerd Font in your terminal profile |
| Colors look flat/wrong | Confirm your terminal has true-color (`echo $COLORTERM` should print `truecolor`) |
| Slow shell startup | Run `zsh -xvs` to profile, or check for a stray `compinit` rebuild loop |
| Aliases not found | Make sure `aliases.zsh` is actually sourced from `.zshrc` |

---

## 🗺️ Roadmap

- [ ] Add a Fish-shell variant of the prompt config
- [ ] Ship a proper `install.sh` with dependency checks
- [ ] Add Hyprland/Sway-aware prompt segment (workspace name)
- [ ] Publish a matching Ghostty/Kitty color scheme

---

## 🤝 Contributing

This is primarily my personal setup, but fixes, ideas, and PRs are always welcome:

1. Fork the repo
2. Create a branch — `git checkout -b feature/cool-idea`
3. Commit — `git commit -am 'Add cool idea'`
4. Push — `git push origin feature/cool-idea`
5. Open a Pull Request

Please keep changes backward-compatible and documented.

---

## 📄 License

Distributed under the MIT License. See [`LICENSE`](LICENSE) for details.

---

## 🙏 Acknowledgements

- [Starship](https://starship.rs/) — cross-shell prompt that just works
- [Oh My Zsh](https://ohmyz.sh/) and its community — endless inspiration
- [zinit](https://github.com/zdharma-continuum/zinit) and the wider zsh-users ecosystem
- [Nerd Fonts](https://www.nerdfonts.com/) — for making terminals beautiful

---

<p align="center">
  <sub>Built with ❤️ by <a href="https://github.com/itachi-re">itachi-re</a></sub>
</p>
