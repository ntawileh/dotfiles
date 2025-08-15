file="$1/fzf.fish"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

echo "Running $1/fzf.fish"
"$1/fzf.fish"
