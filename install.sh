#!/usr/bin/env bash

###################### Boilerplate and preparation ######################

stow_cmd() {
    stow --target "$HOME" "$@"
}

function check_prog() {
    if ! hash "$1" > /dev/null 2>&1; then
        echo "Command not found: $1. Aborting..."
        exit 1
    fi
}

check_prog stow

mkdir -p "$HOME/.config"
#########################################################################
# Set varaibles here
# ex. DESKTOP=hyprland or KDE


############################# How to use it #############################
#                                                                       #
# Uncomment the lines of the configs you want to install below.         #
# Then run this script from within the dotfiles directory.              #
# E.g. `cd ~/.dotfiles; ./install.sh`                                   #
#                                                                       #
# To uninstall the config later, run stow -D in the dotfiles directory. #
# E.g. `cd ~/.dotfiles; stow -D vim`                                    #
#                                                                       #
#########################################################################

stow_cmd git
stow_cmd zsh
stow_cmd --no-folding vim
stow_cmd --no-folding terminator
stow_cmd --no-folding gnupg
stow_cmd --no-folding bashtop
stow_cmd --no-folding geany
stow_cmd tmux
