#!/usr/local/bin/fish
# Matte Black palette for fzf
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#333333,bg:#121212,spinner:#f59e0b,hl:#D35F5F \
  --color=fg:#bebebe,header:#e68e0d,info:#FFC107,pointer:#f59e0b \
  --color=marker:#FFC107,fg+:#bebebe,prompt:#e68e0d,hl+:#D35F5F \
  --color=selected-bg:#333333 \
  --color=border:#8a8a8d,label:#bebebe \
  --cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap --marker=' '"