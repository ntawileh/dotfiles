file="$1/yazi.toml"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

exec_file="$1/yazi.sh"
if [ -f "$exec_file" ]; then
    chmod +x "$exec_file"
    "$exec_file"
fi

EXT_DIR="${HOME}/.config/yazi"

echo "Creating $EXT_DIR/theme.toml"
cat $1/yazi.toml >"$EXT_DIR/theme.toml"
