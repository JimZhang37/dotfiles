#!/usr/bin/env bash

# 1. Set a clean path so it's fast
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# 2. Use the environment variables Sketchybar already gave us!
# $NAME is the item being updated (e.g., space.1)
# $FOCUSED_WORKSPACE is passed by AeroSpace via the event
# $1 is the workspace ID we passed when we created the item

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    label.color=0xffffffff \
    drawing=on
else
  # Check if this space is in the list of non-empty workspaces
  # We do this check only for the specific item being updated
  if aerospace list-workspaces --monitor all --empty no | grep -q "^$1$"; then
    sketchybar --set "$NAME" \
      background.drawing=off \
      label.color=0x44ffffff \
      drawing=on
  else
    sketchybar --set "$NAME" drawing=off
  fi
fi
