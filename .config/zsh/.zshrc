export ZSH="/usr/share/oh-my-zsh/"

# oh my zsh config
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"

autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  docker
	git
  gitignore
	pip
  sudo
	colored-man-pages
  fzf-tab
	)

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin:$CARGO_HOME/bin"
export MANPATH="/usr/local/man:$MANPATH"
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"

# SSH fix
alias ssh='TERM=xterm-256color \ssh'

# Kitty terminal shortcuts
alias icat="kitty +kitten icat"
alias kdiff="kitty +kitten diff"

# Neovim shortcuts
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nvimdiff="nvim -d"
alias vimdiff="nvim -d"

# Newsboat shortcut
alias newsboat="newsboat --refresh-on-start"

# Exa shortcuts
alias e="exa --git --classify"
alias ea="exa --all --git --classify"
alias el="exa --all --git --classify --long"

# rsync cp
alias cpv="rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress"

# Docker
alias dsh='docker exec -it $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  ) sh'
alias dbash='docker exec -it $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  ) bash'
alias drm='docker rm $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  )'
alias drma='docker rm $(  docker ps -a | fzf | awk '"'"'{print $1;}'"'"'  )'

# pacman
alias paci="pacman -Slq | fzf --multi --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
alias pacrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

# Dotfile management shortcuts
alias editdots="vim $HOME/Documents/dotfiles/"
alias deploydots="$HOME/Documents/dotfiles/deploy.sh"

# yarn
alias yarn='yarn --use-yarnrc "${XDG_CONFIG_HOME:-$HOME/.config}/yarn/config"' 

# Completion for kitty
# kitty + complete setup zsh | source /dev/stdin

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# fzf 
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

