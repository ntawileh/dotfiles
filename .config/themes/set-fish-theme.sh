file="$1/fish.fish"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

echo "Running $1/fish.fish"
"$1/fish.fish"
