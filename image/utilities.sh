#!/bin/bash
set -e
source /bd_build/buildconfig

## Often used tools.
#minimal_install less vim-tiny psmisc gpg-agent dirmngr
#run ln -s /usr/bin/vim.tiny /usr/bin/vim

## This tool runs a command as another user and sets $HOME.
run cp /bd_build/bin/setuser /sbin/setuser

## This tool allows installation of apt packages with automatic cache cleanup.
run cp /bd_build/bin/install_clean /sbin/install_clean
