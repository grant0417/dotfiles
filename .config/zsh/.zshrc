# Path to your oh-my-zsh installation.
export ZSH="/usr/share/oh-my-zsh/"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
	git
  gitignore
	pip
  sudo
	colored-man-pages
	)

source $ZSH/oh-my-zsh.sh

export HISTFILE="$HOME/.cache/zsh/zsh_history"

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/opt/cross/bin:$HOME/.cargo/bin/:$HOME/.gem/ruby/2.7.0/bin:$PATH"

# Android Development
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export MANPATH="/usr/local/man:$MANPATH"

export LANG=en_US.UTF-8

export EDITOR='nvim'
export BROWSER='firefox-developer-edition'

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

# Dotfile management shortcuts
alias editdots="vim $HOME/Documents/dotfiles/"
alias deploydots="$HOME/Documents/dotfiles/deploy.sh"

autoload -Uz compinit
compinit -d "$HOME/.cache/zsh/zcompdump"

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    #prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
