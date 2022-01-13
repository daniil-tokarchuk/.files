PROJECTS=$HOME/Projects
DOT_FILES=$PROJECTS/.files
DRIVENBRANDS=$PROJECTS/drivenbrands
if (type brew &>/dev/null); then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$DOT_FILES/zsh:$FPATH"
  autoload -Uz compinit; compinit
  autoload -Uz prompt.zsh; prompt.zsh
  zmodload zsh/complist
fi
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vi
else
  export EDITOR=nvim
fi
source $DOT_FILES/zsh/aliases.zsh
export ANT_HOME=$DRIVENBRANDS/hybris/hybris/bin/platform/apache-ant
export JAVA_HOME=/Library/Java/JavaVirtualMachines/sapmachine-17.jdk/Contents/Home
export PATH=$PATH:$ANT_HOME/bin:$JAVA_HOME/bin
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
