#!/usr/local/bin/fish

set script_path (status -f)
set script_dir (dirname $script_path)
echo "Script directory: $script_dir"
set FISH_CONFIG_DIR ~/.config/fish
cp $script_dir/fish.theme "$FISH_CONFIG_DIR/themes/Kanagawa.fish"

fish_config theme choose Kanagawa
echo y | fish_config theme save
