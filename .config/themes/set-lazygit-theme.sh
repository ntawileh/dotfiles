file="$1/lazygit.yml"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

LSD_DIR="${HOME}/.config/lazygit"

echo "Creating $LSD_DIR/theme.yml"
cat $file >"$LSD_DIR/theme.yml"
