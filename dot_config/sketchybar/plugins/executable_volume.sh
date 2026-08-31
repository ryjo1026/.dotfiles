#!/usr/bin/env bash
if [[ "$SENDER" == "volume_change" ]]; then
  volume="$INFO"
  case "$volume" in
    [6-9][0-9]|100) icon="󰕾" ;;
    [3-5][0-9])     icon="󰖀" ;;
    [1-9]|[1-2][0-9]) icon="󰕿" ;;
    *)              icon="󰝟" ;;
  esac
  sketchybar --set "$NAME" icon="$icon" label="$volume%"
fi
