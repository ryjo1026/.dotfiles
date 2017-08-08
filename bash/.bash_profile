#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Aliases
#
#  ---------------------------------------------------------------------------

#  -----------------------------
#  1. Aliases
#  -----------------------------
# Command Shortcuts
alias ls='ls -G'                            # Prefferred ls (Color)
alias la='ls -la'                           # Shortcut list all

alias cp='cp -iv'                           # Preffered cp (interactive, verbose)
alias mv='mv -iv'                           # Preffered mv (interactive, verbose)

cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (autocorrect)
alias ~="cd ~"                              # Go Home

trash () { command mv "$@" ~/.Trash ; }     # Moves a file to the MacOS trash

alias "^L"='clear'                          # Ensure ctrl+l is clear
alias "browsersync"='browser-sync start --server --files "."' # Watch all files in dir for changes
alias "reload"='source ~/.bash_profile'     # Reload for changes to take effect

# Folder Shortcuts
# TODO
