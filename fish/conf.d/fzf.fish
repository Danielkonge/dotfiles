fish_add_path "/opt/homebrew/opt/fzf/bin"

# Setting fd as the default source for fzf
set -x FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow'

set -x FZF_CTRL_T_COMMAND 'fd --strip-cwd-prefix --hidden --follow'

set -x FZF_ALT_C_COMMAND 'fd --type d --hidden --follow'


# Preview file content using bat (https://github.com/sharkdp/bat)
set -x FZF_CTRL_T_OPTS "\
--preview 'bat -n --color=always {} 2> /dev/null || tree -C -L 1 {}' \
--bind 'ctrl-o:change-preview-window(down|hidden|)' \
--color header:italic \
--header 'Press CTRL-o to move or hide preview'"


# CTRL-O to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
set -x FZF_CTRL_R_OPTS "\
--layout=reverse \
--preview 'echo {}' --preview-window down:3:hidden:wrap \
--bind 'ctrl-o:toggle-preview' \
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
--color header:italic \
--header 'Press CTRL-y to copy command into clipboard | Press CTRL-o to see a preview.'"


# Print tree structure in the preview window
set -x FZF_ALT_C_OPTS "--preview 'tree -C -L 1 {}'"

# Options to fzf command
set -x FZF_COMPLETION_OPTS '--border --info=inline'
