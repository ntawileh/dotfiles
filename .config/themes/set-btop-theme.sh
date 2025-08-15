file="$1/btop.theme"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

EXT_DIR="${HOME}/.config/btop/themes"

echo "Creating $EXT_DIR/auto.theme"
cat $1/btop.theme >"$EXT_DIR/auto.theme"
