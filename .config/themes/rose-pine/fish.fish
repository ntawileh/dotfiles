#!/usr/local/bin/fish

set FISH_CONFIG_DIR ~/.config/fish
wget -O "$FISH_CONFIG_DIR/themes/Rose Pine Moon.theme" https://raw.githubusercontent.com/rose-pine/fish/refs/heads/main/themes/Ros%C3%A9%20Pine%20Moon.theme

fish_config theme choose "Rose Pine Moon"
echo y | fish_config theme save
