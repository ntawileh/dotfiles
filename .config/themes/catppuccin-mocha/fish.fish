#!/usr/local/bin/fish

set FISH_CONFIG_DIR ~/.config/fish
wget -O "$FISH_CONFIG_DIR/themes/Catppuccin Mocha.theme" https://raw.githubusercontent.com/catppuccin/fish/refs/heads/main/themes/Catppuccin%20Mocha.theme

fish_config theme choose "Catppuccin Mocha"
echo y | fish_config theme save
