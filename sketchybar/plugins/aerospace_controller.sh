#!/bin/bash

# --- Setup Debug File ---
DEBUG_FILE="/tmp/aerospace_debug.txt"
echo "--- Update Triggered $(date +%H:%M:%S) ---" >"$DEBUG_FILE"

# 1. Fetch only the workspaces we care about
# List 1: All visible workspaces (even if empty)
# List 2: All non-empty workspaces (even if not visible)
DATA_VISIBLE=$(aerospace list-workspaces --monitor all --visible --format "%{workspace} %{monitor-appkit-nsscreen-screens-id} %{workspace-is-visible} %{workspace-is-focused}")
DATA_NON_EMPTY=$(aerospace list-workspaces --monitor all --empty no --format "%{workspace} %{monitor-appkit-nsscreen-screens-id} %{workspace-is-visible} %{workspace-is-focused}")

# Combine them and remove duplicates
COMBINED_DATA=$(echo -e "$DATA_VISIBLE\n$DATA_NON_EMPTY" | sort -u)

# 2. Reset all workspace items to 'hidden' first
# This ensures that workspaces that just became empty and non-visible disappear
sketchybar --set "/space\..*/" drawing=off

UPDATE_COMMAND=""
LEFT_SIDE_ITEMS=""
RIGHT_SIDE_ITEMS=""

# 3. Process only the workspaces returned by your specific filters
while read -r sid m_id is_visible is_focused; do
  [ -z "$sid" ] && continue
  NAME="space.$sid"

  # Since it's in this list, we definitely want to draw it
  DRAWING="on"

  # --- Styling Logic ---
  if [ "$is_focused" == "true" ]; then
    # Current keyboard focus
    STYLE="background.drawing=on background.color=0xffffffff label.color=0xff000000"
  elif [ "$is_visible" == "true" ]; then
    # Visible on a monitor but not focused
    STYLE="background.drawing=on background.color=0x44ffffff label.color=0xffffffff"
  else
    # Hidden in background but has windows
    STYLE="background.drawing=off label.color=0xffffffff"
  fi

  UPDATE_COMMAND+="--set $NAME drawing=$DRAWING $STYLE "

  # Categorize for the divider reorder (Monitor 2 = Left, Monitor 1 = Right)
  if [ "$m_id" == "2" ]; then
    LEFT_SIDE_ITEMS+="$NAME "
  else
    RIGHT_SIDE_ITEMS+="$NAME "
  fi

  echo "WS: $sid | Mon: $m_id | Vis: $is_visible | Foc: $is_focused" >>"$DEBUG_FILE"
done <<<"$COMBINED_DATA"

# 4. Execute updates
sketchybar $UPDATE_COMMAND
sketchybar --reorder $LEFT_SIDE_ITEMS monitor_divider $RIGHT_SIDE_ITEMS
