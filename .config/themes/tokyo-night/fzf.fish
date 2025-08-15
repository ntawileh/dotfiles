#!/usr/local/bin/fish
# Tokyo Night palette for fzf (adjusted to match existing theme)
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#444b6a,bg:#1a1b26,spinner:#bb9af7,hl:#f7768e \
  --color=fg:#a9b1d6,header:#7aa2f7,info:#7dcfff,pointer:#bb9af7 \
  --color=marker:#b9f27c,fg+:#a9b1d6,prompt:#e0af68,hl+:#f7768e \
  --color=selected-bg:#7aa2f7 \
  --color=border:#565f89,label:#a9b1d6 \
  --cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap --marker='\uf02e '"
