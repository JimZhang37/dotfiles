#!/bin/bash
##### Force all scripts to run the first time (never do this in a script) #####
# --- 2. Define The Event ---
sketchybar --add event aerospace_workspace_change

# --- 3. Initial Creation ---
# Create all workspaces. We don't worry about order here
# because the controller will fix it immediately.
ALL_WORKSPACES=$(aerospace list-workspaces --all --format "%{workspace}")

for sid in $ALL_WORKSPACES; do
  sketchybar --add item space_left."$sid" left \
    --set space_left."$sid" \
    label="$sid" \
    drawing=off \
    label.padding_left=8 \
    label.padding_right=8 \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.drawing=off \
    click_script="aerospace workspace $sid"
done

# Create the Divider
sketchybar --add item monitor_divider left \
  --set monitor_divider \
  label="|" \
  label.font="JetBrainsMono Nerd Font:Bold:16.0" \
  label.padding_left=15 \
  label.padding_right=15

for sid in $ALL_WORKSPACES; do
  sketchybar --add item space_right."$sid" left \
    --set space_right."$sid" \
    label="$sid" \
    drawing=off \
    label.padding_left=8 \
    label.padding_right=8 \
    background.color=0x44ffffff \
    background.corner_radius=5 \
    background.drawing=off \
    click_script="aerospace workspace $sid"
done

# --- 4. The Controller ---
sketchybar --add item aerospace_controller center \
  --set aerospace_controller drawing=off \
  --subscribe aerospace_controller aerospace_workspace_change \
  --set aerospace_controller script="$CONFIG_DIR/plugins/aerospace_controller.sh"

# --- 5. Initial Sync ---
sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
