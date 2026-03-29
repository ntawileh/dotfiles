# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

A theme switcher for dotfiles, inspired by [Omarchy](https://github.com/basecamp/omarchy). It coordinates color schemes across tmux, neovim, yazi, fish, bat, btop, lazygit, lsd, ghostty, alacritty, fzf, and Chrome by copying/symlinking theme files into `~/.config/*`. No build system — just shell scripts and config data.

## Commands

```bash
./theme-picker list          # List all available themes
./theme-picker               # Interactive picker (requires gum + fd)
./theme-picker rose-pine     # Apply a specific theme (writes to real ~/.config)

./set-tmux-theme.sh tokyo-night   # Apply one tool's theme only

bash -n set-tmux-theme.sh    # Syntax check a script
shellcheck set-tmux-theme.sh # Lint a script
shellcheck ./*.sh            # Lint all root scripts
```

`theme-picker` must be run from `~/.config/themes` (this repo root) — theme file paths are relative.

## Architecture

**Dispatcher pattern:** `theme-picker` updates the `current` symlink then calls every `set-*.sh` script in the repo root, passing the theme name as `$1`. Each applier runs independently — failures don't abort the others.

**Each `set-*.sh` applier:**
1. Checks if the theme provides its file (`[ -f "$theme/$file" ]`)
2. If missing: prints to stderr, exits 0 (graceful skip — not all themes support all tools)
3. If present: writes to the target path under `~/.config/` via temp file + atomic move
4. Signals the app to reload (e.g., `tmux source-file`, `killall -SIGUSR2 ghostty`)

**Theme directories** (e.g., `rose-pine/`, `tokyo-night/`) contain the theme's config files in tool-specific formats: `tmux.sh`, `nvim.lua`, `yazi.toml`, `lsd.yaml`, `lazygit.yml`, `btop.theme`, `ghostty`, `alacritty.toml`, `fish.fish`, `fzf.fish`, `backgrounds/`.

**Common target paths written by appliers:**
- tmux: `~/.config/tmux/colors.sh`
- nvim: `~/.config/nvim/lua/plugins/theme.lua`
- yazi: `~/.config/yazi/theme.toml`
- lsd: `~/.config/lsd/colors.yaml`
- lazygit: `~/.config/lazygit/theme.yml`
- btop: `~/.config/btop/themes/auto.theme`

## Code Style

**Shell scripts:**
- Shebang: `#!/usr/local/bin/bash`
- Indentation: 4 spaces (match the file you're editing)
- Variables: `UPPER_SNAKE_CASE` constants, `lower_snake_case` locals
- Use `$(...)` not backticks; quote all paths
- Write via temp file then atomic move: `>"$config.tmp" && mv "$config.tmp" "$config"`
- Do NOT use `set -e` globally in batch appliers — prefer explicit `[ -f ... ]` checks
- `exit 0` for "theme doesn't support this tool"; non-zero only for real failures

**Adding a new `set-*.sh` applier:** accept `$1` as theme name, check for the theme file, exit 0 when missing, write to the correct `~/.config/` path, do not delete user files unless replacing a managed symlink.

**Adding a new theme directory:** create a top-level directory with the same file names other themes use. Not all files are required — appliers handle missing files gracefully.

**Lua (`nvim.lua`):** return a table with LazyVim plugin specs; 4-space indentation.

**YAML/TOML:** minimal diffs, stable ordering, no trailing whitespace.
