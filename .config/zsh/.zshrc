# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt autocd		# Automatically cd into typed directory.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

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
)

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin"
export PATH="$PATH:$CARGO_HOME/bin"

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
alias ls='exa'
alias la='exa -a'
alias ll='exa -al'
alias e='ls --git --classify'
alias ea='la --git --classify'
alias el='ll --git --classify'

# rsync cp
alias cpv='rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress'

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

alias cross='sudo env "PATH=$PATH" "RUSTUP_HOME=$(echo ~/.rustup)" cross'

# yarn
alias yarn='yarn --use-yarnrc "${XDG_CONFIG_HOME:-$HOME/.config}/yarn/config"' 

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# fzf 
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# kill|ps compleations
zstyle ':completion:*:*:*:*:processes' \
    command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' \
    'fzf-preview [[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' \
    fzf-flags --preview-window=down:3:wrap

# systemctl compleations
zstyle ':fzf-tab:complete:systemctl-*:*' \
    fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# env compleations
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'

# git compleations
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' \
    fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' \
    fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' \
    fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' \
    fzf-preview \
	'case "$group" in
	    "commit tag") git show --color=always $word ;;
	    *) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' \
    fzf-preview \
	'case "$group" in
	    "modified file") git diff $word | delta ;;
	    "recent commit object name") git show --color=always $word | delta ;;
	    *) git log --color=always $word ;;
	esac'

# man compleations
zstyle ':fzf-tab:complete:(\\|)run-help:*' \
    fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' \
    fzf-preview 'man $word'

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
