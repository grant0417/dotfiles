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
