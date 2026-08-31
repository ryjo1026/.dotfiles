#!/usr/bin/env bash
PERCENTAGE="$(pmset -g batt | grep -Eo '\d+%' | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

[[ -z "$PERCENTAGE" ]] && exit 0

if [[ -n "$CHARGING" ]]; then
  icon="󰂄"
else
  case "$PERCENTAGE" in
    9[0-9]|100) icon="󰁹" ;;
    [6-8][0-9]) icon="󰂀" ;;
    [3-5][0-9]) icon="󰁾" ;;
    [1-2][0-9]) icon="󰁻" ;;
    *)          icon="󰁺" ;;
  esac
fi

sketchybar --set "$NAME" icon="$icon" label="$PERCENTAGE%"
