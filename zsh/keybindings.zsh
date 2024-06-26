# ----------------------------------------
# Keybindings
# ----------------------------------------

# Enable history search with arrows
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Allow mid-word completion
bindkey '^I' expand-or-complete-prefix

# Fix delete key inputing ~ issue
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char