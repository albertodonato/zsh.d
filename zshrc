# -*- mode: sh -*-

fpath+=( $(realpath $(dirname ${(%):-%x}))/autoload )

# emacs-style bindings
bindkey -e

# history
setopt HIST_FCNTL_LOCK
setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY

# completion
setopt EXTENDEDGLOB

ZSH_DISABLE_COMPFIX=true
autoload -U compinit && compinit -u
zmodload zsh/complist

_comp_options+=(globdots)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# editing
autoload -U select-word-style && select-word-style bash

# prompt
setopt PROMPT_SUBST

autoload -Uz vcs_info
precmd_functions+=( vcs_info )

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' get-revision true
zstyle ':vcs_info:git:*' formats       ' %b(%8.8i) %u%c'
zstyle ':vcs_info:git:*' actionformats ' %b(%i)|%a %u%c'

local newline=$'\n'
PROMPT="%F{8}┌─╼ %F{cyan}%n%F{blue}@%m%f  %F{green}%~%f  %F{yellow}\${vcs_info_msg_0_}%f"
PROMPT+="${newline}%F{8}└─╼%f "
RPROMPT="%(?.%F{green}🗸.%F{red}%? ✗)%f"
