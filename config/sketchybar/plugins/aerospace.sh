#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh"

# SketchyBar may run with a limited PATH under launchd, so use the Homebrew path directly.
focused_workspace=$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)

if [ -n "$focused_workspace" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=$SPACE_ACTIVE_BG_COLOR \
    icon.color=$SPACE_ACTIVE_COLOR \
    label="$focused_workspace" \
    label.color=$SPACE_ACTIVE_COLOR \
    label.drawing=on
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    label="--" \
    label.drawing=on \
    icon.color=$SPACE_INACTIVE_COLOR \
    label.color=$SPACE_INACTIVE_COLOR
fi
