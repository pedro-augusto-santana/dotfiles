# ZSH CONFIGURATION FILE
# BECAUSE OMZ IS TOO SLOW

autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
autoload -U colors && colors # Enable colors in prompt
autoload -Uz add-zsh-hook vcs_info

add-zsh-hook precmd vcs_info

## GIT SECTION
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' (*)'
zstyle ':vcs_info:*' stagedstr ' (+)'
# zstyle ':vcs_info:*' formats ' on %B%F{green}%b %%b%u%c%f'
zstyle ':vcs_info:*' formats ' on %F{green}%b %u%c%f'

eval "$(dircolors -b)"

del-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}
zmodload -i zsh/complist

zle -N del-word
bindkey '^W' del-word

compinit
zstyle ':completion:*' menu yes select # menu selection for shell (like zsh)
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case insensitive cd
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle '*' single-ignored show

## CUSTOM ALIASES
export VISUAL=micro
export EDITOR="$VISUAL"
export PATH="$PATH:/home/pedro/.local/texlive/2021/bin/x86_64-linux"
export PATH="$PATH:$HOME/.cargo/env"
export PATH="$PATH:/usr/local/go/bin"
export GO111MODULE=on
export PATH="$PATH:$HOME/.config/composer/vendor/bin/"
export DOTNET_ROOT="$HOME/Libs/dotnet/"
export PATH="$PATH:/home/pedro/Libs/dotnet/"
export PATH="$PATH:/home/pedro/.local/bin/"

alias vim="nvim"
alias v="vim"
alias del="gio trash"
alias zshconfig="vim ~/.zshrc"
alias convert="magick convert"

## BASE ALIASES
alias ls='ls --color=auto'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias lS='ls -1FSsh'

alias grep='grep --color'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias g='git'

alias md=mkdir

# useful dots
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

## OPTIONS
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_SPACE # ignore commands that start with space
setopt HIST_NO_STORE
setopt AUTO_CD
setopt MENU_COMPLETE

## COMMAND NOT FOUND
if [[ -x /usr/lib/command-not-found ]] ; then
	if (( ! ${+functions[command_not_found_handler]} )) ; then
		function command_not_found_handler {
			[[ -x /usr/lib/command-not-found ]] || return 1
			/usr/lib/command-not-found --no-failure-msg -- ${1+"$1"} && :
		}
	fi
fi



### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions
## End of Zinit's installer chunk

bindkey "^[OA" history-substring-search-up
bindkey "^[OB" history-substring-search-down
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -M menuselect '^M' .accept-line

bindkey '^[[Z' reverse-menu-complete

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=""
HISTORY_SUBSTRING_SEARCH_FUZZY=""
HISTORY_SUBSTRING_SEARCH_PREFIXED="true"

## PROMPT
setopt PROMPT_SUBST
## old prompt
# PROMPT="%F{cyan}$%f "
 #PROMPT+='%B%F{blue}%2~%f%b'
 #PROMPT+='${vcs_info_msg_0_} %% '

PROMPT='%B%F{blue}%n@ %2~%f%b'
PROMPT+='${vcs_info_msg_0_} '
PROMPT+="%F{cyan}%f%% "
