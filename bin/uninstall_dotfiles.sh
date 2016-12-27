#! /usr/bin/env bash

echo "======================================================"
echo " Uninstalling Dotfiles"
echo "======================================================"
find . -type l -maxdepth 1 | xargs -I {} sh -c 'if [[ "$(readlink {})" == *"dotfiles"* ]]; then unlink {}; fi'
