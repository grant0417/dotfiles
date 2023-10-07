export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

if [[ -f "$ZDOTDIR/env.zsh" ]] && [[ "$OSTYPE" != "darwin"* ]]; then
    source "$ZDOTDIR/env.zsh"
fi

. "/home/grant/.local/share/cargo/env"
