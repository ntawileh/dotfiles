file="$1/ghostty"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

config="$HOME/.config/ghostty/config"
theme_file="$1/ghostty"

echo $theme
cat "$config" | grep -v "^theme =" | grep -v "^background-opacity =" >"$config.tmp"
cat $theme_file >>"$config.tmp"
mv "$config.tmp" "$config"

#osascript ./reload-ghostty.scpt
killall -SIGUSR2 ghostty
