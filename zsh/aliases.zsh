# ----------------------------------------
# ALIASES
# ----------------------------------------

alias "newtab"='open . -a iterm'                        # Open pwd in new iTerm tab
alias "kraken"='open -na "GitKraken" --args -p $(pwd)'  # Open pwd in GitKraken
alias "chrome"='open -a "Google Chrome"'                # Open file in Chrome (best used with .html)

alias "zshrc"='source ~/.zshrc'                         # Reload the shell with preferences
alias "serve"='python3 -m http.server 8000'             # Start the simple python server to serve pwd

alias "grep"='grep --color'                             # Make grep colorful
alias "ccat"='pygmentize'                               # Make ccat colorful
alias "ls"='ls -G'                                      # Make ls colorful

alias "la"='ls -la'                                     # la lists all files

# Git
alias "git_current_branch"='git branch | grep \* | cut -d " " -f2'

# Fun
alias "vscode-bomb"='while true; do open -a "Safari"; done'
