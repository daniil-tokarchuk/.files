alias g='git'
alias q='exit'
alias v='nvim'
alias l='ls -AlFh'
alias u='brew update && brew upgrade --greedy && brew autoremove && brew cleanup --prune=all'
alias uz='v ~/.zshrc && . ~/.zshrc'
alias ug='v ~/.gitconfig'
alias cdp='cd ~/Projects'
alias cd.='cd ~/Projects/.files'
alias cdg='cd ~/Projects/gds_oms'
alias cdc='cd ~/Projects/configurator'
alias jenkins='/usr/local/opt/openjdk@21/bin/java -Dmail.smtp.starttls.enable\=true -jar /usr/local/opt/jenkins-lts/libexec/jenkins.war --httpListenAddress\=127.0.0.1 --httpPort\=8080'
for i in {1..5}; do
  alias $(printf '.%.s' {0..$i})="cd $(printf '../%.s' {1..$i})"
done

export N_PREFIX=~/.n; PATH+=":$N_PREFIX/bin"

setopt NO_BEEP
setopt globdots
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
zstyle ':completion:*' menu select
autoload compinit; compinit

bindkey -v; KEYTIMEOUT=1
zle-line-init() { echo -n '\e[6 q'}; zle -N zle-line-init 
zle-keymap-select() { echo -n "\e[$([[ $KEYMAP == main ]] && echo 6 || echo 2) q" }; zle -N zle-keymap-select
cli() {
  PROMPT='%~ > '
  if ! [ -d .git ]; then 
    RPROMPT='' 
	return
  fi
  local git_info=$(git status -sb && git stash list -n 1)
  local branch_info=${git_info%%$'\n'*}
  local file_statuses=$(echo $git_info | awk '{print $1}')
  [[ $branch_info =~ [[:space:]]([^.]*) ]] && RPROMPT="λ:$match[1]"
  [[ $branch_info =~ behind   ]] && RPROMPT+=' <'
  [[ $branch_info =~ ahead    ]] && RPROMPT+=' >'
  [[ $file_statuses =~ A      ]] && RPROMPT+=' a'
  [[ $file_statuses =~ [MT]   ]] && RPROMPT+=' m'
  [[ $file_statuses =~ D      ]] && RPROMPT+=' d'
  [[ $file_statuses =~ R      ]] && RPROMPT+=' r'
  [[ $file_statuses =~ UU     ]] && RPROMPT+=' ='
  [[ $file_statuses =~ \\?\\? ]] && RPROMPT+=' u'
  [[ $file_statuses =~ stash  ]] && RPROMPT+=' s'
}; autoload add-zsh-hook; add-zsh-hook precmd cli
