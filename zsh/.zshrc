# Enable for profiling
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Install antidote if not present
if [[ ! -d ${ZDOTDIR:-~}/.antidote ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi


# globbing preferences need to be set to make sure the next lines work
setopt GLOB_DOTS
setopt extendedglob

# Load all .zsh config files from ~/.zsh
if [ -d ~/.zsh ]; then
  # Source non-dotfiles first (to make sure compinit happens first)
  for file in ~/.zsh/[!.]*.zsh; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done

  # Source dotfiles next
  for file in ~/.zsh/.*.zsh; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
fi


source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# Dynamically load macOS specific plugins
if [[ "$(uname 2>/dev/null)" == "Darwin" ]]; then
  antidote load ${ZDOTDIR:-~}/.zsh_plugins_macos.txt

  # iTerm shell extensions
  if [ -f ~/.iterm2_shell_integration.zsh ]; then
    source ~/.iterm2_shell_integration.zsh
  fi

  # Source Mac specific settings
  source ${ZDOTDIR:-~}/.zshrc.mac
fi

# Load local config last
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# Enable for profiling
# zprof