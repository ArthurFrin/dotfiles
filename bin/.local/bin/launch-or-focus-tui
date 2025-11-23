#!/bin/bash

APP_ID="custom.$(basename "$1")"
LAUNCH_COMMAND="$@"

exec uwsm-app-or-focus "$APP_ID" "uwsm-app -- xdg-terminal-exec --app-id=$APP_ID -e $LAUNCH_COMMAND"
