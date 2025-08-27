#!/usr/local/bin/fish
# Gruvbox palette for fzf (matches gruvbox/fish.theme)
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#504945,bg:#282828,spinner:#8ec07c,hl:#d3869b \
  --color=fg:#ebdbb2,header:#b8bb26,info:#fabd2f,pointer:#8ec07c \
  --color=marker:#b8bb26,fg+:#ebdbb2,prompt:#d3869b,hl+:#d3869b \
  --color=selected-bg:#504945 \
  --color=border:#504945,label:#ebdbb2 \
  --cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap "
