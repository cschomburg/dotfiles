#!/usr/bin/env bash

# Determine the current OS
if [[ "$(uname)" == "Darwin" ]]; then
    OS="darwin"
elif [[ -f /etc/nixos/configuration.nix ]]; then
    OS="nixos"
else
    echo "Unsupported operating system"
    exit 1
fi

# Set the source directory
SRC=$HOME/.dotfiles/nixos

if [[ "$OS" == "nixos" ]]; then
    # NixOS specific operations
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

    sudo NIX_CURL_FLAGS='--retry 1000' nixos-rebuild --keep-failed --show-trace $operation

elif [[ "$OS" == "darwin" ]]; then
    # macOS (Darwin) specific operations
    nix build .#darwinConfigurations.$(hostname).system \
        --extra-experimental-features 'nix-command flakes'

    sudo ./result/sw/bin/darwin-rebuild switch --flake .#paragon
fi
