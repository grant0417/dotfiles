# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
[[ -f "$ZDOTDIR/env.zsh" ]] && [[ "$OSTYPE" == "darwin"* ]] && source "$ZDOTDIR/env.zsh"

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

[[ -f "$ZDOTDIR/alias.zsh" ]] && source "$ZDOTDIR/alias.zsh"

# fzf
if [[ -d "/usr/share/fzf" ]]; then
    # arch location
    FZF_SHELL_DIR="/usr/share/fzf"
elif [[ -x $(command -v brew) ]] && [[ -d "$(brew --prefix)/opt/fzf/shell" ]]; then
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
