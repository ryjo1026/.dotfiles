#!/bin/bash
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
# Style                                                                       #
###############################################################################
defaults write "Apple Global Domain" "AppleInterfaceStyle" "Dark"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################
# Mouse Speed
defaults write -g com.apple.mouse.scaling 12
defaults write -g com.apple.trackpad.scaling 24

###############################################################################
# Trackpad
###############################################################################

# Disable "natural" scrolling
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Turn on secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

# Turn off natural scrolling
# defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
# Map bottom right corner to right-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Swipe between pages with three fingers
#defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
#defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Force Click and haptic feedback
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true

# Silent clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

# Haptic feedback
# 0: Light
# 1: Medium
# 2: Firm
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 2
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 2

# Tracking Speed
# 0: Slow
# 3: Fast
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3.0

# Disable swipe between pages
defaults write AppleEnableSwipeNavigateWithScrolls -bool false

# Enable three finger drag
#defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
#defaults write com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad -int 1

###############################################################################
# Saving                                                                      #
###############################################################################
# Always expand save file dialog boxes
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

###############################################################################
# Printing                                                                    #
###############################################################################
# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Always expand print dialog boxes
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
defaults write com.apple.dock wvous-tl-corner -int 5
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# ###############################################################################
# # Time Machine                                                                #
# ###############################################################################

# # Prevent Time Machine from prompting to use new hard drives as backup volume
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# # Disable local Time Machine backups
# # hash tmutil &> /dev/null && sudo tmutil disablelocal

# ###############################################################################
# # Terminal                                                                    #
# ###############################################################################
# # Get rid of funk noise when backspacing
# plutil -replace 'Window Settings.Basic.Bell' -bool 0 ~/Library/Preferences/com.apple.Terminal.plist

# ###############################################################################
# # Activity Monitor                                                            #
# ###############################################################################

# # Show the main window when launching Activity Monitor
# defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# # Visualize CPU usage in the Activity Monitor Dock icon
# defaults write com.apple.ActivityMonitor IconType -int 5

# # Show all processes in Activity Monitor
# defaults write com.apple.ActivityMonitor ShowCategory -int 0

# # Sort Activity Monitor results by CPU usage
# defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# defaults write com.apple.ActivityMonitor SortDirection -int 0

# ###############################################################################
# # Photos                                                                      #
# ###############################################################################

# # Prevent Photos from opening automatically when devices are plugged in
# defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# ###############################################################################
# # iTunes                                                                      #
# ###############################################################################

# # Prevent iTunes from opening automatically when devices are plugged in
# defaults write com.apple.iTunesHelper ignore-devices 1

# ###############################################################################
# # Google Chrome & Google Chrome Canary                                        #
# ###############################################################################

# # Disable the all too sensitive backswipe on trackpads
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
# defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# # Disable the all too sensitive backswipe on Magic Mouse
# defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
# defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# # Use the system-native print preview dialog
# defaults write com.google.Chrome DisablePrintPreview -bool true
# defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# # Expand the print dialog by default
# defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
# defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# # Misc

# # Show icons for hard drives, servers, and removable media on the desktop
# defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
# defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# # Finder: show hidden files by default
# defaults write com.apple.finder AppleShowAllFiles -bool true

# # Finder: show all filename extensions
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# # Finder: show status bar
# defaults write com.apple.finder ShowStatusBar -bool true

# # Finder: show path bar
# defaults write com.apple.finder ShowPathbar -bool true

# # Display full POSIX path as Finder window title
# defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# # Keep folders on top when sorting by name
# defaults write com.apple.finder _FXSortFoldersFirst -bool true

# # When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# # Disable the warning when changing a file extension
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# # Don’t show recent applications in Dock
# defaults write com.apple.dock show-recents -bool false

# # Stop the dock from moving around
# defaults write com.apple.Dock position-immutable -bool yes

# # Disable Autocorrect
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# # Show only open applications in the Dock
# #defaults write com.apple.dock static-only -bool true

# # Don’t animate opening applications from the Dock
# defaults write com.apple.dock launchanim -bool false

# # Speed up Mission Control animations
# defaults write com.apple.dock expose-animation-duration -float 0.1

# # Don’t group windows by application in Mission Control
# # (i.e. use the old Exposé behavior instead)
# defaults write com.apple.dock expose-group-by-app -bool false

# # Disable Dashboard
# defaults write com.apple.dashboard mcx-disabled -bool true

# # Don’t show Dashboard as a Space
# defaults write com.apple.dock dashboard-in-overlay -bool true

# # Change minimize/maximize window effect
# defaults write com.apple.dock mineffect -string "scale"

# # Show the ~/Library folder
# chflags nohidden ~/Library

# # Show the /Volumes folder
# sudo chflags nohidden /Volumes

# # Avoid creating .DS_Store files on network or USB volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# # Disable smart dashes as they’re annoying when typing code
# defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# # Disable automatic period substitution as it’s annoying when typing code
# defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# # Disable smart quotes as they’re annoying when typing code
# defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# # Reveal IP address, hostname, OS version, etc. when clicking the clock
# # in the login window
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# # Disable the sound effects on boot
# sudo nvram SystemAudioVolume=" "

# # Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# # Make Chrome Default Browser
# open -a "Google Chrome" --args --make-default-browser

# # Update clock format to EEE d MMM h:mm:ss a (example: Thu 18 Aug 11:46:18 pm)
# defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM h:mm:ss a"

# # Show battery percentage
# defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# # Turn off Mission Control and Spaces
# defaults write com.apple.dock mcx-expose-disabled -bool true

# # Displays have separate Spaces
# defaults write com.apple.spaces spans-displays -bool true

# # Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# # Turn off power chime noise – the beeping when plugged in and closed at night
# defaults write com.apple.PowerChime ChimeOnNoHardware -bool true && killall PowerChime 2> /dev/null;

# killall SystemUIServer
# killall Dock

# echo "Done. Note that some of these changes require a logout/restart to take effect."
