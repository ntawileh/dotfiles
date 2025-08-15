file="$1/nvim.lua"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

config="$HOME/.config/nvim/lua/plugins/theme.lua"
theme_file="$1/nvim.lua"

echo $theme_file
cat $theme_file >"$config.tmp"
mv "$config.tmp" "$config"
