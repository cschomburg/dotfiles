#!/usr/bin/env bash

SRC=$HOME/.dotfiles/nixos
sudo rsync --filter="protect /hardware-configuration.nix" \
           --filter="protect /flake.lock" \
           --filter="protect /hostname" \
           --filter="protect /nixpkgs" \
           --filter="exclude,s *.gitignore" \
           --filter="exclude,s *.gitmodules" \
           --filter="exclude,s *.git" \
           --filter="exclude .*.swp" \
           --filter="exclude Session.vim" \
           --delete --recursive --perms \
           $SRC/ /etc/nixos/

if [ $# -eq 0 ]; then
  operation='switch'
else
  operation=$1
fi
cd $wd
sudo NIX_CURL_FLAGS='--retry 1000' nixos-rebuild --fast --keep-failed --show-trace $operation
