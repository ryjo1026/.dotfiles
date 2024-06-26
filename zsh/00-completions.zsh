# ----------------------------------------
# Completions
# ----------------------------------------

# Compinit once a day
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

# Set the completer style for all completion contexts
zstyle ':completion:*' completer \
  _expand \
  _complete \
  _ignored \
  _approximate

# select completions with arrow keys
zstyle ':completion:*' menu select   
# group results by category                                       
zstyle ':completion:*' group-name ''                                        

# Set the maximum number of errors for approximate matching
zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Enable warnings before applying approximate matches
zstyle ':completion:*:approximate:*' warn yes