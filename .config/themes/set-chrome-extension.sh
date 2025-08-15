file="$1/chrome.sh"
if [ -f "$file" ]; then
    echo "Theming $file"
else
    echo "File not found: $file. Skipping..." >&2
    exit 0
fi

EXT_DIR="${HOME}/Library/Application Support/Google/Chrome/External Extensions"
SYMLINK="chrome-theme.json"

source $1/chrome.sh

rm "$(readlink $SYMLINK)"
rm "$SYMLINK"

echo "Creating $EXT_DIR/$EXTENSION_ID.json"
echo '{"external_update_url": "https://clients2.google.com/service/update2/crx"}' >"$EXT_DIR/$EXTENSION_ID.json"

ln -sf "$EXT_DIR/$EXTENSION_ID.json" "$SYMLINK"
