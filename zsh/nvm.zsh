# ----------------------------------------
# NVM - Load nvm only on usage
# ----------------------------------------

# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .zshrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ ! "$(whence -w __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack' 'npm-check')
  function __init_nvm() {
    if [ ! -s "$HOME/.nvm/nvm.sh" ]; then
      read -q "yn?No nvm installation found. Install now? (y/n)"
      case $yn in
      [Yy]*) curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | PROFILE=/dev/null zsh ;;
      [Nn]*) return 0 ;;
      *) echo "Please answer yes or no." ;;
      esac
    fi
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi
