
shopt -s autocd

# aliases
# alias vim="nvim"
alias v="nvim"
alias del="gio trash"
alias bashconfig="v ~/.bashrc"
alias ls='ls --color=auto'
alias l='ls -lFh'
alias bat='batcat'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh' 
alias ll='ls -l'
alias lS='ls -1FSsh'

export PATH="$PATH:/home/pedro/.local/bin/"
export PATH="$PATH:/home/pedro/.local/texlive/2022/bin/x86_64-linux"
export VISUAL=micro
export EDITOR=VISUAL

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias o='xdg-open'
alias md=mkdir

# git magic
alias g='git'
alias gs='git status'
alias gp='git push'

# zsh like completion
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# better tab completion
bind 'set match-hidden-files off'
bind 'set show-all-if-ambiguous on'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set colored-stats on'
bind 'set menu-complete-display-prefix on'
bind 'TAB:menu-complete'
bind '"\e[Z":menu-complete-backward'

# makes ctrl-w more well behaved
stty werase undef
bind '"\C-w": backward-kill-word'

parse_git_branch() {
    git_info=$(__git_ps1)
    if [[ $git_info ]]; then
        echo "$git_info " | sed 's/^[ \t]*//' # returns the prompt without the leading space
    else
        echo "" # no vcs information is needed
    fi
}

# prompt configuration
export PROMPT_DIRTRIM=2
export PS1="\$(parse_git_branch)\[$(tput sgr0)\]\u@ \[\e[32m\]\w\[\e[m\] % "
#export PS1="\$(__git_ps1) \[$(tput sgr0)\]\u@ \[\e[32m\]\w\[\e[m\] % "
