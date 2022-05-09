export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox-developer-edition"
export READER="zathura"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

export LESSHISTFILE="-"

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
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/npmrc"
export MINIKUBE_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/minikube"
export CUDA_CACHE_PATH="${XDG_CACHE_HOME:-$HOME/.cache}/nv"

export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="${XDG_CONFIG_HOME:-$HOME/.config}/java"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/pass"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"

export DOCKER_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME:-$HOME/.local/share}/docker-machine"

export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export MOZ_X11_EGL=1

