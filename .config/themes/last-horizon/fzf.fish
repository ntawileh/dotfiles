#!/usr/local/bin/fish
#
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#6B5E73,bg:#0c0b0c,spinner:#87a9b0,hl:#b59790 \
--color=fg:#FAFCFB,header:#c4d8e2,info:#87a9b0,pointer:#FAFCFB \
--color=marker:#a5a0b6,fg+:#FAFCFB,prompt:#87a9b0,hl+:#c4d8e2 \
--color=selected-bg:#080708 \
--color=border:#584e51,label:#FAFCFB \
--cycle --layout=reverse --border --ansi --height=80% --preview-window=wrap --marker='* '"
