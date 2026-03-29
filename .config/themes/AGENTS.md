# Agent Guide (themes)

This repository is a theme switcher: mostly configuration files + small shell scripts that copy/symlink theme files into other apps (tmux, nvim, yazi, etc.). There is no single build system.

Checked for agent rules:
- Cursor rules: none found in `.cursor/rules/` or `.cursorrules`.
- Copilot rules: none found in `.github/copilot-instructions.md`.

## Commands (Build / Lint / Test)

### Day-to-day
- List themes (from repo root): `./theme-picker list`
- Pick interactively (requires `gum` + `fd`): `./theme-picker`
- Apply a specific theme (run from repo root): `./theme-picker rose-pine`

Notes:
- `theme-picker` assumes it is run from `~/.config/themes` (this repo). If you run it elsewhere, theme file paths may not resolve.
- Applying a theme modifies files in your home config (for example `~/.config/tmux/colors.sh`).

Tooling dependencies (not vendored here):
- Interactive picker: `gum`, `fd`
- Some scripts may rely on: `tmux`, `fish`, `wget`, `killall`, `terminal-notifier`, `automator` (macOS)

Safety:
- Treat any `set-*.sh` invocation as a write to your real dotfiles; there is no built-in dry-run mode.
- Prefer validating with `bash -n` / `shellcheck` before running a script you changed.

### "Lint" (what exists here)
There is no configured linter, but these are the most useful checks for this codebase:

- Shell syntax check (single file): `bash -n set-tmux-theme.sh`
- Shell lint (single file): `shellcheck set-tmux-theme.sh`
- Shell lint (all root scripts): `shellcheck ./*.sh`
- Optional formatting (if you use it): `shfmt -w set-tmux-theme.sh`

### "Tests" (what exists here)
There is no test runner in this repo. Practical validation is mostly "smoke testing":

- Run one script against one theme directory (be careful: writes into `~/.config`):
  - `./set-tmux-theme.sh rose-pine`
  - `./set-nvim-theme.sh rose-pine`

Convenient single "test"-like checks:
- Picker listing works: `./theme-picker list` (expects one theme directory name per line)
- Picker applies without crashing: `./theme-picker rose-pine` (watch for `Failed:` lines)

If you add tests later, prefer `bats-core` for shell scripts:
- Run all tests: `bats test/`
- Run a single test file: `bats test/theme-picker.bats`
- Run a single test by name/pattern: `bats test/theme-picker.bats -f "lists themes"`

## Repository Layout (what to expect)

- Theme directories: `catppuccin-mocha/`, `rose-pine/`, `tokyo-night/`, etc.
- The active theme is symlinked at: `current` (points to a theme directory)
- Root scripts apply theme files into app configs:
  - `set-tmux-theme.sh`, `set-nvim-theme.sh`, `set-yazi-theme.sh`, `set-lsd-theme.sh`, ...
- `theme-picker` runs all `./*.sh` scripts (in this repo root) and passes the selected theme name as `$1`.

Theme directory conventions (common files; not all themes have all of these):
- `tmux.sh` (shell variables for tmux colors)
- `nvim.lua` (Lua plugin spec for LazyVim)
- `yazi.toml`, `yazi.sh`
- `lsd.yaml`, `lazygit.yml`, `btop.theme`
- `ghostty`, `alacritty.toml`
- `backgrounds/` and a `background` symlink

## Code Style Guidelines

### General principles
- Preserve local style: do not reformat entire files; keep existing indentation and quoting conventions unless you are already editing nearby lines.
- Keep scripts idempotent: re-running should result in the same final state.
- Missing theme support is not an error: if a theme does not provide a file, print a message to stderr and `exit 0` (so the overall theme apply can continue).
- Avoid surprises: these scripts touch `~/.config/*` and may signal running apps (`tmux`, `ghostty`). Be explicit and conservative.
- No secrets: do not add tokens/credentials or machine-specific secrets.

### Shell scripts (`*.sh`)
Shebangs / shell:
- Existing scripts are bash and some use `#!/usr/local/bin/bash`. Prefer bash for new scripts; match the existing shebang where practical.

Imports:
- Use `source` only for simple "data" files (example: `source "$theme/chrome.sh"`).
- Always quote paths in `source`, `cat`, `rm`, `mv`, `ln`, etc.

Formatting:
- Keep indentation consistent with the file (many scripts use 4 spaces).
- Prefer `$(...)` over backticks.

Types / data handling:
- Prefer explicit variable names: `THEMES_DIR`, `EXT_DIR`, `theme_file`.
- Use arrays + `mapfile` when handling file lists (see `theme-picker`).

Naming:
- Files/directories: `kebab-case` (already used across themes).
- Variables: `UPPER_SNAKE_CASE` for constants, `lower_snake_case` for locals.

Error handling:
- For scripts that are run in a batch (`set-*.sh`), do not `set -e` globally unless you are careful; one failing command could abort early.
- Prefer explicit checks:
  - verify input: `[ -f "$file" ]` / `[ -d "$dir" ]`
  - verify required commands when needed: `command -v tmux >/dev/null || exit 0`
- Use `exit 0` for "not applicable" (missing theme file); use non-zero only for real failures.
- If removing/replacing symlinks, check they exist first (`[ -L ... ]`) and avoid unguarded `rm "$(readlink ...)"`.

Safe file writes:
- Write via a temp file then move into place (existing pattern: `>"$config.tmp"; mv ...`).
- Prefer `mktemp` for unique temp names when races matter.

### Fish scripts (`*.fish`)
- Keep them executable if invoked directly (`chmod +x` is used by the root scripts).
- Avoid interactive prompts unless the caller expects it; if needed, document it.

### Lua (`nvim.lua`)
Imports / structure:
- Theme files typically `return { ... }` with LazyVim/Lazy plugin specs.
- Prefer `require("plugin").setup(opts)` inside a `config = function(_, opts)` block.

Formatting:
- Follow existing style in the file (Lua here commonly uses 4-space indentation).

Naming:
- Use descriptive plugin `name` fields when the plugin requires it; keep options in `opts`.

### YAML/TOML/theme files
- Keep stable ordering and minimal diffs; these files are primarily data.
- Avoid trailing whitespace; keep quoting consistent with the file.

## Adding or Updating Themes

- Add a new theme as a top-level directory with the same file names other themes use.
- If you add a new root applier script (`set-*.sh`), ensure it:
  - accepts `$1` as the theme directory name
  - checks for the theme file and `exit 0` when missing
  - writes to the correct target path under `~/.config/*`
  - does not delete user files unless it is replacing a managed symlink/file

Common target paths used by existing appliers:
- tmux: `~/.config/tmux/colors.sh` (then `tmux source-file ~/.config/tmux/tmux.conf`)
- nvim: `~/.config/nvim/lua/plugins/theme.lua`
- yazi: `~/.config/yazi/theme.toml` (and optional executable theme hook `yazi.sh`)
- lsd: `~/.config/lsd/colors.yaml`
- lazygit: `~/.config/lazygit/theme.yml`
- btop: `~/.config/btop/themes/auto.theme`
- ghostty: currently signals `ghostty` to reload (`killall -SIGUSR2 ghostty`)
- chrome extension: writes into `~/Library/Application Support/Google/Chrome/External Extensions/`

## Quick "Single Target" Recipes

- Apply only tmux colors for one theme: `./set-tmux-theme.sh tokyo-night`
- Validate one script without running it: `bash -n ./set-next-wallpaper.sh`
- Shellcheck one script: `shellcheck ./theme-picker`
