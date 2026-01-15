#!/bin/bash

# --- Setup Debug File ---
DEBUG_FILE="/tmp/aerospace_debug.txt"
echo "--- Update Triggered $(date +%H:%M:%S) ---" >"$DEBUG_FILE"

# 1. Fetch workspaces
DATA_VISIBLE=$(aerospace list-workspaces --monitor all --visible --format "%{workspace} %{monitor-appkit-nsscreen-screens-id} %{workspace-is-visible} %{workspace-is-focused}")
DATA_NON_EMPTY=$(aerospace list-workspaces --monitor all --empty no --format "%{workspace} %{monitor-appkit-nsscreen-screens-id} %{workspace-is-visible} %{workspace-is-focused}")

COMBINED_DATA=$(echo -e "$DATA_VISIBLE\n$DATA_NON_EMPTY" | sort -u)

# 2. Reset ALL items to 'off' initially

UPDATE_COMMAND=""

# 3. Process workspaces
while read -r sid m_id is_visible is_focused; do
  [ -z "$sid" ] && continue

  # Use TARGET_ITEM instead of NAME to avoid conflict with Sketchybar's built-in $NAME
  if [ "$m_id" == "2" ]; then
    TARGET_ITEM="space_left.$sid"
  else
    TARGET_ITEM="space_right.$sid"
  fi

  # --- Styling Logic ---
  if [ "$is_focused" == "true" ]; then
    STYLE="background.drawing=on background.color=0xffffffff label.color=0xff000000"
  elif [ "$is_visible" == "true" ]; then
    STYLE="background.drawing=on background.color=0x44ffffff label.color=0xffffffff"
  else
    STYLE="background.drawing=off label.color=0xffffffff"
  fi

  # Turn ON only the item assigned to the current monitor
  UPDATE_COMMAND+="--set $TARGET_ITEM drawing=on $STYLE "

  echo "WS: $sid | Mon: $m_id | Target: $TARGET_ITEM" >>"$DEBUG_FILE"
done <<<"$COMBINED_DATA"

sketchybar --set "/space_left\..*/" drawing=off \
  --set "/space_right\..*/" drawing=off \
  $UPDATE_COMMAND
# 4. Execute updates
