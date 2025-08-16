#!/usr/local/bin/fish

wget -O "$(bat --config-dir)/themes/Rose Pine.tmTheme" https://raw.githubusercontent.com/Msouza91/rose-pine.yazi/refs/heads/main/rose-pine.tmTheme

bat cache --build
set -Ux BAT_THEME "Rose Pine"
