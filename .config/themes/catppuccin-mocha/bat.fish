#!/usr/local/bin/fish

wget -O "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

bat cache --build
set -Ux BAT_THEME "Catppuccin Mocha"
