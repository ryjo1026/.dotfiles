# ----------------------------------------
# NVM - Load nvm only on usage
# ----------------------------------------

export NVM_DIR=/Users/ryanjohnston/.nvm

nvm() {
  if [[ -d '/Users/ryanjohnston/.nvm' ]]; then
    NVM_DIR="/Users/ryanjohnston/.nvm"
    export NVM_DIR
    # shellcheck disable=SC1090
    source "${NVM_DIR}/nvm.sh"
    if [[ -e ~/.nvm/alias/default ]]; then
      PATH="${PATH}:${HOME}.nvm/versions/node/$(cat ~/.nvm/alias/default)/bin"
    fi
    # invoke the real nvm function now
    nvm "$@"
  else
    echo "nvm is not installed" >&2
    return 1
  fi
}

# Normal loading
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"