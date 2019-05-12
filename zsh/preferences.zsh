# ----------------------------------------
# PREFERENCES
# ----------------------------------------

# Variables
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Load in OpenSSL vars
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib

# ZSH options
setopt auto_cd                      # cd by typing directory name if it's not a command

export ZSH_AUTOSUGGEST_USE_ASYNC=1
