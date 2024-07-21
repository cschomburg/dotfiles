#!/usr/bin/env bash

nix build .#darwinConfigurations.paragon.system \
   --extra-experimental-features 'nix-command flakes'

./result/sw/bin/darwin-rebuild switch --flake .#paragon
