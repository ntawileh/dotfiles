file="$1/bat.fish"
if [ -f "$file" ]; then
    echo "Running $file"
    "$file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi
