
# Put the following in .zshenv:
# export ZDOTDIR = "$HOME/.config/zsh"

# Set PATH
path+=("$HOME/.emacs.d/bin")
path+=("$HOME/.luarocks/bin")
path+=("$HOME/.config/scripts/")
export -U PATH

export EDITOR=nvim
# export VISUAL=nvim

# setting EDITOR=nvim makes zsh think we want vi mode,
# so we change back to emacs keybindings like this:
set -o emacs

# CTRL+X CTRL+E to edit command line input in nvim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi

source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

[ -f ~/.config/zsh/.fzf.zsh ] && source ~/.config/zsh/.fzf.zsh

# source via . instead of source
. ~/.config/zsh/wezterm.sh

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Note: The above can be faster sometimes, but the below one has better highlighting
# source /opt/homebrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# >>> conda initialize >>> !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(starship init zsh)"



