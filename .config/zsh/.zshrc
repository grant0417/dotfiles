# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Enable colors and change prompt:
autoload -U colors && colors
setopt autocd
setopt interactive_comments

# History in cache directory
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Basic auto/tab complete
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# SSH fix
alias ssh='TERM=xterm-256color \ssh'

# Neovim shortcuts
alias nvimdiff="nvim -d"

alias hx="helix"

# Newsboat shortcut
alias newsboat="newsboat --refresh-on-start"

# Exa shortcuts
alias e='exa --git --classify'
alias ea='exa --git --classify'
alias el='exa --git --classify'

# rsync cp
alias cpv='rsync -pogbr -hhh --backup-dir=/tmp/rsync -e /dev/null --progress'

# Docker
# shellcheck disable=SC2142
alias dsh='docker exec -it $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  ) sh'
# shellcheck disable=SC2142
alias dbash='docker exec -it $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  ) bash'
# shellcheck disable=SC2142
alias drm='docker rm $(  docker ps | fzf | awk '"'"'{print $1;}'"'"'  )'
# shellcheck disable=SC2142
alias drma='docker rm $(  docker ps -a | fzf | awk '"'"'{print $1;}'"'"'  )'

# pacman
# shellcheck disable=SC2142
alias paci="pacman -Slq | fzf --multi --preview 'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk \"{print \$2}\")' | xargs -ro sudo pacman -S"
alias pacrm="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias paclean='pacman -Qtdq | sudo pacman -Rns -'

# Dotfile management shortcuts
alias editdots="nvim \$HOME/Documents/dotfiles/"
alias deploydots="\$HOME/Documents/dotfiles/deploy.sh"

alias cross='sudo env "PATH=$PATH" "RUSTUP_HOME=$(echo ~/.rustup)" cross'

# Git
alias ga='git add'
alias gc='git commit'
alias gw='git worktree'
alias gs='git status'
alias gpr='git pull --rebase'

# fzf
if [[ -d "/usr/share/fzf" ]]; then
    # arch location
    FZF_SHELL_DIR="/usr/share/fzf"
elif [[ -d "$(brew --prefix)/opt/fzf/shell" ]]; then
    # mac location
    FZF_SHELL_DIR="$(brew --prefix)/opt/fzf/shell"
else
    echo "fzf shell dir not found"
fi

[[ $- == *i* ]] && source "${FZF_SHELL_DIR}/completion.zsh" 2> /dev/null
source "${FZF_SHELL_DIR}/key-bindings.zsh"

# zoxide
if [[ -x "$(command -v zoxide)" ]]; then
    eval "$(zoxide init zsh)"

    c () {
        if [[ -x "$(command -v code-insiders)" ]]; then
            CODE=code-insiders
        elif [[ -x "$(command -v code)" ]]; then
            CODE=code
        else
            echo "No code editor found"
            return 1
        fi

        if [[ "$#" -eq 0 ]]; then
            $CODE .
        elif [[ "$#" -eq 1 ]] && [[ -d "$1" ]]; then
            (cd "$1" && $CODE .)
        elif [[ "$#" -eq 1 ]] && [[ -e "$1" ]]; then
            $CODE "$1"
        else
            \builtin local result
            result="$(\command zoxide query --exclude "$(\builtin pwd -L)" -- "$@")" &&
                (cd "${result}" && $CODE .)
        fi
    }

    n () {
        if [[ "$#" -eq 0 ]]; then
            nvim .
        elif [[ "$#" -eq 1 ]] && [[ -d "$1" ]]; then
            (cd "$1" && nvim .)
        elif [[ "$#" -eq 1 ]] && [[ -e "$1" ]]; then
            nvim "$1"
        else
            \builtin local result
            result="$(\command zoxide query --exclude "$(\builtin pwd -L)" -- "$@")" &&
                (cd "${result}" && nvim .)
        fi
    }

else
    echo "zoxide not found"
fi

# starship
if [[ -x "$(command -v starship)" ]]; then
    eval "$(starship init zsh)"
else
    echo "starship not found"
fi

timeshell() {
    shell=${1-$SHELL}
    echo "Timing $shell"
    unset FIG_TERM
    unset FIG_HOSTNAME
    unset FIGTERM_SESSION_ID
    unset FIG_LOG_LEVEL
    for _ in $(seq 1 10); do /usr/bin/time "$shell" -li -c exit; done
}

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
