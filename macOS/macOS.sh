#!/bin/bash

###############################################################################
# @ryjo1026's sane macOS settings                                             #
###############################################################################
# Sources:
#	https://mac-how-to.gadgethacks.com/how-to/change-os-x-s-annoying-default-settings-using-terminal-0162471/
#	https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

###############################################################################
# Energy Saver                                                                #
###############################################################################
# Disable system sleep when charging
sudo pmset -c sleep 0

# Disable disk sleep when charging
sudo pmset -c disksleep 0

# Disable display sleep when charging
sudo pmset -c displaysleep 0

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Hot corners
# Bottom left corner activates screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
