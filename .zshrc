DOT_FILES=$HOME/Projects/.files
fpath=($DOT_FILES/zsh $fpath)
autoload -Uz prompt.zsh; prompt.zsh
autoload -Uz compinit; compinit
zmodload zsh/complist
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vi
else
  export EDITOR=nvim
fi
source $DOT_FILES/zsh/aliases.zsh
export KEYTIMEOUT=1
set -o vi
setopt globdots
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'
    function zle-keymap-select {
        if [[ $KEYMAP == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ $KEYMAP == main ]] ||
            [[ $KEYMAP == viins ]] ||
            [[ $KEYMAP = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }
    zle-line-init() {
        echo -ne $cursor_beam
    }
    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:warnings' format '%F{red}-- no matches --%f'
