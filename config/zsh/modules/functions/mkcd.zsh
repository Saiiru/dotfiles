#!/usr/bin/env zsh
# mkcd.zsh — Creates a directory and changes into it.

# mkcd: Creates a directory (if it doesn't exist) and then changes the current directory to it.
# Arguments:
#   $1: The path to the directory to create and change into.
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }