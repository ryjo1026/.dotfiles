# .dotfiles
My dotfiles managed with dotbot. A constant work in progress!

## Dotbot

Install the submodule
```
git submodule init
git submodule update
```

## ZSH
Antibody is used for plugins over Oh-My-ZSH! for speed reasons. Dotfiles are organized in a modular fashion, ```.zshrc``` just sources in all the files in ```~/.zsh```, source in a ```.zshrc.local``` if it exists, and installs necessary plugins via Antibody. This zsh setup aims to be completely OS agnostic so I can have the same setup on any environment.

```.zshrc``` will attempt to install Antibody if it doesn't exist but the Antibody install script isn't perfect and oftentimes won't know which package to get. Should this happen just go to the [git release page](https://github.com/getantibody/antibody/releases) and install manually. Add any antibody plugins needed to ```.zsh_plugins.txt```.

A few useful features:
* Compinit is only loaded once a day (```completions.zsh```) for speed.
* NVM is only loaded when it's first called (```nvm.zsh```) for speed.
* iTerm and brew plugins are only loaded on macOS.


## Vim
On first run of vim, vundle should automatically install. Sometimes it has trouble getting packages. The command to install them is:
```
vim +PluginInstall +qall
```