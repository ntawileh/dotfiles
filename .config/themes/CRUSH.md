# CRUSH.md

## Build / Lint / Test Commands

- **This repo consists primarily of configuration files and shell scripts; there is no primary build or test system.**
- Run shell scripts directly (e.g. `./set-nvim-theme.sh`). Make scripts executable with `chmod +x <script>.sh`.
- No linters configured; use `shellcheck` for shell scripts if desired: `shellcheck *.sh`
- For `lua` config (especially for neovim): optionally run `luacheck` for linting.
- To check workflow or AppleScript files, use built-in tools (e.g. Automator).

## Code Style Guidelines

- **Imports:** For Lua, use local imports and prefer returning tables from modules.
- **Formatting:**
  - Use 2 spaces for YAML, YAML-like theme files, and Lua.
  - For shell scripts, indent with 2 spaces (or tabs, stay consistent with project).
- **Types:** Shell scripts are untyped; Lua configs are dynamically typed.
- **Naming Conventions:**
  - Use `kebab-case` for shell scripts and theme directories.
  - Use lowercase or snake_case for variables in shell, local variables in Lua.
  - Use PascalCase for exported Lua modules (rare in this repo).
- **Error Handling:**
  - For shell, use `set -e` or `set -euo pipefail` where safe.
  - Check for command errors and test `$?` as needed.
- **General Config:**
  - Prefer copying or symlinking configs rather than editing system files directly.
  - Theme and background image names should be descriptive and short; use jpg/png extensions.
- **Comments:**
  - Comment where config is unclear/has magic values.
  - Use `#` for shell/YAML, `--` for Lua.

## Agent/Automation Notes

- Do not add secrets, tokens, or credentials to this repo.
- Automate script testing by running them from the root or via cron.
- For agentic file changes, follow above naming/formatting rules and keep scripts portable (no Linux-or-macOS-only code without clear reason).

---

#### Misc
- Add `.crush` directory to `.gitignore`:
  `.crush/
`