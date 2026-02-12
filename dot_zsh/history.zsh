# ----------------------------------------
# HISTORY
# ----------------------------------------

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Remove older duplicate entries from history
setopt hist_ignore_all_dups
# Remove superfluous blanks from history items 
setopt hist_reduce_blanks
# Save history entries as soon as they are entered
setopt inc_append_history 
# Share history between shells
setopt SHARE_HISTORY