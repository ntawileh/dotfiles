#!/usr/local/bin/fish

set script_path (status -f)
set script_dir (dirname $script_path)
set FISH_CONFIG_DIR ~/.config/fish

cp $script_dir/fish.theme "$FISH_CONFIG_DIR/themes/LastHorizon.theme"

fish_config theme choose "LastHorizon"
echo y | fish_config theme save
