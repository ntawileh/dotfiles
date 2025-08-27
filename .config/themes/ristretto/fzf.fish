#!/usr/local/bin/fish
# Ristretto palette for fzf
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#403e41,bg:#2c2525,spinner:#a8a9eb,hl:#fd6883 \
  --color=fg:#e6d9db,header:#f38d70,info:#85dacc,pointer:#a8a9eb \
  --color=marker:#adda78,fg+:#e6d9db,prompt:#f9cc6c,hl+:#fd6883 \
  --color=selected-bg:#f38d70 \
  --color=border:#463a3a,label:#e6d9db \
  --cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap"
