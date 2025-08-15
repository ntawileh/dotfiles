#!/usr/local/bin/fish
# Installs a Tokyo Night theme for bat (if available), using closest upstream
wget -O "$(bat --config-dir)/themes/Tokyo Night.tmTheme" \
    https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme

bat cache --build
set -Ux BAT_THEME tokyonight_night
