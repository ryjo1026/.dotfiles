# Install antidote if not present
if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
fi

# Load all .zsh config files from ~/.zsh
if [ -d ~/.zsh ]; then
  for file in ~/.zsh/*.zsh; do
    if [ -f "$file" ]; then
      source $file
    fi
  done
fi
# Load local config last
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load .zsh/.zsh_plugins.txt

# Dynamically load macOS specific plugins
if [[ "$(uname 2>/dev/null)" == "Darwin" ]]; then
  antidote load .zsh/.zsh_plugins_macos.txt

  # iTerm shell extensions
  if [ -f ~/.iterm2_shell_integration.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
  fi
fi
