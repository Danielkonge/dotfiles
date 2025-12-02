if status is-interactive
    # Commands to run in interactive sessions can go here
end

### PATH ###

fish_add_path --append "/Users/daniel/.luarocks/bin" "/Users/daniel/.config/scripts"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda3/bin/conda
    eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

fish_add_path --path "/opt/homebrew/bin"

### Setup ###

set -U fish_greeting

function fish_hybrid_key_bindings --description \
"Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings fish_hybrid_key_bindings

set -x EDITOR nvim
set -x VISUAL nvim

set -x MANPAGER 'nvim +Man!'

fzf --fish | source

starship init fish | source
