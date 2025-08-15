file="$1/lsd.yaml"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

LSD_DIR="${HOME}/.config/lsd"

echo "Creating $LSD_DIR/colors.yaml"
cat $1/lsd.yaml >"$LSD_DIR/colors.yaml"
