# Add completions
fpath=(/usr/local/share/zsh-completions $fpath)

# Path to your oh-my-zsh installation.
export ZSH=/Users/ryanjohnston/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Plugins found in ~/.oh-my-zsh/plugins/*
# Custom plugins added to ~/.oh-my-zsh/custom/plugins/
plugins=(git osx colored-man colorize github pip python brew zsh-syntax-highlighting z)

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh

# User configuration for agnoster theme
DEFAULT_USER="ryanjohnston"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# ----------------------------------------
# CUSTOM ALIASES
# ----------------------------------------
alias "newtab"='open . -a iterm'                        # Open pwd in new iTerm tab
alias "kraken"='open -na "GitKraken" --args -p $(pwd)'  # Open pwd in 

# ----------------------------------------
# CUSTOM FUNTIONS
# ----------------------------------------
function mkcd() {
    mkdir $1 && cd $1
}

# Include warp directory script
wd() {
  . /Users/ryanjohnston/bin/wd/wd.sh
}

export NVM_DIR=/Users/ryanjohnston/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Load in OpenSSL vars
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/ryanjohnston/Development/EventbriteAlexaSkill/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/ryanjohnston/Development/EventbriteAlexaSkill/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/ryanjohnston/Development/EventbriteAlexaSkill/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/ryanjohnston/Development/EventbriteAlexaSkill/node_modules/tabtab/.completions/sls.zsh