#!/usr/local/bin/bash

# Cycles through the background images available

BACKGROUNDS_DIR="$PWD/current/backgrounds/"
CURRENT_BACKGROUND_LINK="$PWD/current/background"
SOLID_BACKGROUND="$PWD/solid-bg.jpg"

mapfile -d '' -t BACKGROUNDS < <(find "$BACKGROUNDS_DIR" -type f -print0 | sort -z)
TOTAL=${#BACKGROUNDS[@]}

if [[ $TOTAL -eq 0 ]]; then
    terminal-notifier -message "No backgrounds found" -title "Set Next Wallpaper"
else
    automator -i "$SOLID_BACKGROUND" ./setDesktopWallpaper.workflow
    # Get current background from symlink
    if [[ -L "$CURRENT_BACKGROUND_LINK" ]]; then
        CURRENT_BACKGROUND=$(readlink "$CURRENT_BACKGROUND_LINK")
    else
        # Default to first background if no symlink exists
        CURRENT_BACKGROUND=""
    fi

    # Find current background index
    INDEX=-1
    for i in "${!BACKGROUNDS[@]}"; do
        if [[ "${BACKGROUNDS[$i]}" == "$CURRENT_BACKGROUND" ]]; then
            INDEX=$i
            break
        fi
    done

    # Get next background (wrap around)
    if [[ $INDEX -eq -1 ]]; then
        # Use the first background when no match was found
        NEW_BACKGROUND="${BACKGROUNDS[0]}"
    else
        NEXT_INDEX=$(((INDEX + 1) % TOTAL))
        NEW_BACKGROUND="${BACKGROUNDS[$NEXT_INDEX]}"
    fi

    # Set new background symlink
    ln -nsf "$NEW_BACKGROUND" "$CURRENT_BACKGROUND_LINK"

    automator -i "$NEW_BACKGROUND" ./setDesktopWallpaper.workflow
fi
