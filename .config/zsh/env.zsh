# This is the normal contents of .zshenv, but we don't want to do anything on macos
# where we just source the .zshrc file and do everything there, this is due to the weird
# way that macos handles $PATH with path_helper

export LANG=en_US.UTF-8

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export MBSYNCRC="${XDG_CONFIG_HOME:-$HOME/.config}/mbsync/config"
export ELECTRUMDIR="${XDG_DATA_HOME:-$HOME/.local/share}/electrum"

export PSQLRC="${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc"
export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/pg/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf"

export PYTHONHISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/python/python_history"
export STACK_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/stack"
export MINIKUBE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/minikube"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/pass"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/docker-machine"


if [[ -d "/usr/local/bin" ]] && [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then
    export PATH="/usr/local/bin:$PATH"
fi

# if on macOS, add homebrew to path
if [[ "$OSTYPE" == "darwin"* ]] && [[ -d /opt/homebrew ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    export PATH="/opt/homebrew/opt/node@18/bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Add cargo binaries to path
if [[ -n "$CARGO_HOME" ]]; then
    export PATH="$CARGO_HOME/bin:$PATH"
fi

# Add haskell binaries to path
if [[ -d "$HOME/.cabal/bin" ]]; then
    export PATH="$HOME/.cabal/bin:$PATH"
fi

if [[ -d "$HOME/.ghcup/bin" ]]; then
    export PATH="$HOME/.ghcup/bin:$PATH"
fi

if [ -x "$(command -v opam)" ]; then
    # opam env --switch default
    eval $(opam env --switch default)
fi

# Editor: nvim, vim, vi
if [ -x "$(command -v nvim)" ]; then
    export EDITOR="nvim"
elif [ -x "$(command -v vim)" ]; then
    export EDITOR="vim"
elif [ -x "$(command -v vi)" ]; then
    export EDITOR="vi"
fi

# Terminal: wezter, kitty, alacritty, xterm
if [ -x "$(command -v wezterm)" ]; then
    export TERMINAL="wezterm"
elif [ -x "$(command -v kitty)" ]; then
    export TERMINAL="kitty"
elif [ -x "$(command -v alacritty)" ]; then
    export TERMINAL="alacritty"
elif [ -x "$(command -v xterm)" ]; then
    export TERMINAL="xterm"
fi

# Browser: firefox-developer-edition, firefox, chromium
if [ -x "$(command -v firefox-developer-edition)" ]; then
    export BROWSER="firefox-developer-edition"
elif [ -x "$(command -v firefox)" ]; then
    export BROWSER="firefox"
elif [ -x "$(command -v chromium)" ]; then
    export BROWSER="chromium"
fi

export READER="zathura"
export PAGER="less"

export LESSHISTFILE="-"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

if [[ "$OSTYPE" == "linux"* ]]; then
  export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
  export MOZ_X11_EGL=1
  export MOZ_ENABLE_WAYLAND=1

  export QT_QPA_PLATFORMTHEME=qt5ct
fi


[ -f "${CARGO_HOME}/env" ] && . "${CARGO_HOME}/env"

export ZSH_ENV_LOADED=1

