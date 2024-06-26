# .dotfiles
My dotfiles managed with dotbot.

## Dotbot

Install the submodule
```
git submodule init
git submodule update
```

## ZSH
Anti~~body~~dote is used for plugins over Oh-My-ZSH! for speed reasons. Dotfiles are modular, ```.zshrc``` just sources in all the files in ```~/.zsh```, source in a ```.zshrc.local``` if it exists, and installs necessary plugins via Antidote. This zsh setup aims to be completely OS agnostic so I can have the same setup on any environment.

A few useful features:
* Compinit is only loaded once a day (```completions.zsh```) for speed.
* NVM is only loaded when it's first called (```nvm.zsh```) for speed.
* iTerm and brew plugins are only loaded on macOS.


## Vim
On first run of vim, vundle should automatically install. Sometimes it has trouble getting packages. The command to install them is:
```
vim +PluginInstall +qall
```