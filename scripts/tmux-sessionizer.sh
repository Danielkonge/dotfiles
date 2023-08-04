#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find -L ~/.config ~/personal ~ ~/Dropbox -mindepth 1 -maxdepth 1 -type d | sed -r 's/\/Users\/daniel/~/g' | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_dir=$(dirname "$selected")
selected_name="$(basename "$selected_dir" | tr . _) $(basename "$selected" | tr . _)"
tmux_running=$(pgrep tmux)
selected_full=$(echo $selected | sed -r 's/~/\/Users\/daniel/g')

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c $selected_full
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c $selected_full
fi

tmux switch-client -t "$selected_name"
