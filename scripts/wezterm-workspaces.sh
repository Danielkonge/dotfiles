#!/bin/bash

dirs=$(find -L ~/Work ~/Personal ~ ~/.config ~/Dropbox  -mindepth 1 -maxdepth 1 -type d)
nice_dirs=$(echo "$dirs" | sed -r 's/\/Users\/daniel/~/g')

prev_dirs=$(echo "$nice_dirs" | xargs dirname | xargs basename)
cur_dirs=$(echo "$nice_dirs" | xargs basename)

# NOTE: $ shouldn't be in any paths name
workspaces=$(/opt/homebrew/bin/parallel --link echo ::: "$dirs" ::: "\$" ::: "$prev_dirs" ::: " 󰳠  " ::: "$cur_dirs")

workspaces="/Users/daniel \$ Home
$workspaces"

echo "$workspaces"
