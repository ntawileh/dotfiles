#!/usr/local/bin/fish
# Ethereal palette for fzf (adjusted to match existing theme)
set -Ux FZF_DEFAULT_OPTS "\
  --color=bg+:#6d7db6,bg:#060B1E,spinner:#ead7e7,hl:#ED5B5A \
  --color=fg:#ffcead,header:#7d82d9,info:#c2c4f0,pointer:#ead7e7 \
  --color=marker:#c4cfc4,fg+:#ffcead,prompt:#E9BB4F,hl+:#ED5B5A \
  --color=selected-bg:#7d82d9 \
  --color=border:#6d7db6,label:#ffcead \
  --cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap --marker=' '"