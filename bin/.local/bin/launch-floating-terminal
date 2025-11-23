#!/bin/bash

cmd="$*"

exec setsid uwsm-app -- xdg-terminal-exec \
    --app-id=custom.floating.terminal \
    --title="Terminal flottant" \
    -e bash -c "$cmd"
