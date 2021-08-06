# ZSH CONFIGURATION FILE
# BECAUSE OMZ IS TOO SLOW

autoload -Uz compinit && compinit
autoload -U promptinit && promptinit
autoload -U colors && colors # Enable colors in prompt
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git*' formats " on %F{green} %b%f"
eval "$(dircolors -b)"

precmd() { vcs_info }

del-word() {
    local WORDCHARS=${WORDCHARS/\//}
    zle backward-delete-word
}

zle -N del-word
bindkey '^W' del-word

compinit
zstyle ':completion:*' menu select # menu selection for shell (like zsh)
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' # case insensitive cd
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## CUSTOM ALIASES
export VISUAL=micro
export EDITOR="$VISUAL"
export PATH="$PATH:/home/pedro/.local/texlive/2021/bin/x86_64-linux"
export PATH="$PATH:$HOME/.cargo/env"
alias vim="nvim"
alias v="vim"
alias del="gio trash"
alias zshconfig="vim ~/.zshrc"

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

## OPTIONS
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt AUTO_CD

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

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=""
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=""
HISTORY_SUBSTRING_SEARCH_FUZZY=""
HISTORY_SUBSTRING_SEARCH_PREFIXED="true"

## PROMPT
setopt PROMPT_SUBST
PROMPT="%F{cyan}$%f "
PROMPT+='%B%F{blue}%2~%f%b${vcs_info_msg_0_} %% '

## SETUP LS COLORS
