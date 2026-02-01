# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Chezmoi-managed dotfiles for Linux (primary) and macOS. Owner: Grant Gurvis (`grant0417`).

## Chezmoi Commands

```shell
chezmoi apply                  # Apply dotfiles to home directory
chezmoi diff                   # Preview changes before applying
chezmoi edit <target>          # Edit a managed file (opens source)
chezmoi add <file>             # Add a new file to management
chezmoi re-add                 # Re-add modified managed files
chezmoi managed                # List all managed files
chezmoi data                   # Show template data (email, etc.)
```

Chezmoi source is at `~/.local/share/chezmoi`, targets deploy to `~/.config/` and `~/`.

## Templating

Files ending in `.tmpl` use Go text/template syntax with chezmoi functions. Template data is defined in `.chezmoi.toml.tmpl` (prompts for `email` on init). Key templated files:
- `dot_config/git/config.tmpl` — uses `{{ .email }}`
- `dot_config/rbw/config.json.tmpl` — uses `{{ .email }}`
- `dot_config/zsh/dot_zshenv.tmpl`, `zshrc_pre.tmpl` — OS-conditional (`{{ if ne .chezmoi.os "darwin" }}`)
- `symlink_dot_zshenv.tmpl`, `symlink_dot_profile.tmpl` — symlink targets

## External Dependencies

Defined in `.chezmoiexternal.toml`, fetched automatically on `chezmoi apply`:
- zsh-syntax-highlighting (v0.8.0)
- zsh-autosuggestions (v0.7.0)

Installed to `~/.local/share/shell-plugins/`.

## Repository Layout

Chezmoi naming conventions: `dot_` → `.`, `symlink_` → symlink, `.tmpl` → templated.

Key configurations managed:
- **Shell**: Zsh (`dot_config/zsh/`) — env, aliases, completions, fzf/zoxide integration, starship prompt
- **Editor**: Neovim (`dot_config/nvim/`) — LazyVim framework, plugins in `lua/plugins/`, formatters config in `stylua.toml`
- **Git**: `dot_config/git/config.tmpl` — delta pager, SSH signing, GitHub CLI credential helper
- **Terminals**: WezTerm (`dot_config/wezterm/`), Kitty (`dot_config/kitty/`)
- **WMs**: i3 (`dot_config/i3/`), Sway (`dot_config/sway/`) with respective bars (Polybar, Waybar)
- **Prompt**: Starship (`dot_config/starship.toml`)

## Neovim Details

Uses LazyVim starter. Plugin specs go in `dot_config/nvim/lua/plugins/`. LazyVim extras enabled: Copilot, Rust (`lang.rust`). Colorscheme: Tokyo Night. Lua formatted with StyLua (2-space indent, 120 col width).

## Platform Conditionals

Several configs branch on OS. Zsh env/aliases handle Linux vs macOS paths (e.g., Homebrew, fzf location). When editing `.tmpl` files, preserve chezmoi template guards.
