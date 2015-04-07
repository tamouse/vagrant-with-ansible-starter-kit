#!/bin/sh
# Modifications to user environment for using rvm (Ruby Version Manager) http://rvm.io
[[ -s "$HOME/.rvm/scripts/rvm" ]] && \
    source "$HOME/.rvm/scripts/rvm" && \
    export PATH="$PATH:$HOME/.rvm/bin"
