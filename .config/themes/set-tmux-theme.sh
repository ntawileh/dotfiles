file="$1/tmux.sh"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

config="$HOME/.config/tmux/colors.sh"
theme_file="$1/tmux.sh"

echo $theme_file
cat $theme_file >"$config.tmp"
mv "$config.tmp" "$config"

tmux source-file ~/.config/tmux/tmux.conf && tmux display-message "tmux.conf reloaded."
