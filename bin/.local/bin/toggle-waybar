#!/usr/bin/env bash
# Toggle Waybar: stop if running, start if not.
# Usage: toggle-waybar.sh

set -euo pipefail

if pgrep -x waybar >/dev/null 2>&1; then
	# Stop all waybar instances
	pkill -x waybar
else
	# Start waybar in background detached from terminal
	nohup waybar >/dev/null 2>&1 &
	disown
fi
