# Install antibody if not present
if [[ $(command -v antibody) == "" ]]; then
  if [[ "$(uname 2> /dev/null)" == "Darwin" ]] && [[ $(command -v brew) != "" ]]; then
    brew install getantibody/tap/antibody
  else
    # Handle the specific install method I use on Unraid
    if [[ -f ~/bin/antibody ]]; then
      PATH=$PATH:~/bin
    else
      curl -sL git.io/antibody | sh -s
    fi
  fi
fi

# Load all .zsh config files from ~/.zsh
if [ -d ~/.zsh ]; then
  for file in ~/.zsh/*.zsh; do 
      if [ -f "$file" ]; then
          source $file
      fi
  done
fi
# Load local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Load antibody plugins TODO static speedup?
source <(antibody init)
antibody bundle < ~/.zsh/.zsh_plugins.txt

# Dynamically load macOS specific plugins
if [[ "$(uname 2> /dev/null)" == "Darwin" ]]; then
  antibody bundle robbyrussell/oh-my-zsh path:plugins/brew

  # iTerm shell extensions
  if [ -f ~/.iterm2_shell_integration.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
  fi
fi
