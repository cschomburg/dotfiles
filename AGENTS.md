# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles plus the full NixOS / nix-darwin system configuration for all the
owner's machines and servers. There is no build/test/lint pipeline — changes are
"applied" by deploying symlinks or rebuilding a Nix system.

## Common Commands

```bash
./deploy                 # no args: print usage and exit
./deploy default         # symlink the core dotfiles into $HOME
./deploy desktop         # link GUI/terminal configs (ghostty, systemd user units)
./deploy skills [name]   # symlink Claude skills into ~/.claude/skills/ (all, or one named)
./deploy private         # run private/deploy (git-crypt encrypted secrets)
./deploy deps            # brew bundle (installs packages from ./Brewfile)
./deploy nixos           # run nixos/rebuild.sh

cd nixos && ./rebuild.sh # rebuild the current machine (NixOS switch, or darwin-rebuild)
./push <host>            # rsync this repo to <host>:code/conf/dotfiles/ (respects .gitignore)
```

`rebuild.sh` auto-detects the OS: on NixOS it rsyncs `nixos/` into `/etc/nixos/` and runs
`nixos-rebuild <switch|...>`; on macOS it `nix build`s and runs `darwin-rebuild switch`.

## Architecture

### Dotfile deployment (`deploy`)
`deploy` is a Bash script driven by `files_default` / `files_desktop` arrays of
`src:dst` pairs. `install_filepair` symlinks each `src` (repo-relative) to `dst`
(`$HOME`-relative), replacing existing symlinks but refusing to overwrite real files.
To add a dotfile, add a `src:dst` entry to the appropriate array — do not write to
`$HOME` directly. Note dotfiles land in non-obvious places (e.g. `git/gitconfig` →
`~/.gitconfig`, `fish/config.fish` → `~/.config/fish/config.fish`).

### NixOS / nix-darwin (`nixos/`)
- `flake.nix` defines `nixosConfigurations` (prophecy, aspect, citadel, ghostwarden)
  and `darwinConfigurations` (paragon). nixpkgs is pinned to `nixos-26.05`, with
  `nixpkgs-unstable` available as an input.
- NixOS hosts share `configuration.nix`, which reads `./hostname` and imports
  `profiles/default.nix` + `machines/<hostname>.nix`. Darwin hosts import their
  machine file directly (e.g. `machines/paragon.nix`).
- **Composition model:** machine files are thin (hardware + host specifics) and pull
  in reusable `profiles/*.nix` (desktop, development, devops, laptop, etc.). Put
  cross-machine config in a profile, machine-specific config in `machines/`.
- `hardware-configuration.nix`, `flake.lock`, `hostname`, and `nixpkgs` are
  machine-local and protected from `rebuild.sh`'s rsync — they are not in the repo.

### Private / encrypted content
- Secrets live under `private/` and `nixos/private/`, encrypted with **git-crypt**
  (see `.git-crypt/`, GPG key). Without the key these files are opaque blobs.
- `nixos/configuration.nix` only imports `private/machines/<host>.nix` when
  `nixos/private/state` reads `unlocked`; otherwise the build throws "private
  directory is locked". Unlock git-crypt before rebuilding a host that needs secrets.

### Other components
- `nvim/` — Neovim config (`init.vim` + `lua/`, lazy.nvim plugins under `lua/plugins/`).
- `bin/` — personal scripts, symlinked onto `$PATH` via the `.dotfiles` link.
- Terminal/shell configs: `fish/`, `tmux`, `starship.toml`, `ghostty/`.

## Conventions
- Shell scripts use `#!/usr/bin/env bash` with `set -eu`; `.shellcheckrc` is deployed.
- Adding a machine: create `nixos/machines/<hostname>.nix`, register it in
  `flake.nix`, and (for NixOS) ensure `nixos/hostname` matches on that host.
