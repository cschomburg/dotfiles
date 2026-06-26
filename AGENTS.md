# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for all the owner's machines. There is no build/test/lint
pipeline — changes are "applied" by deploying symlinks into `$HOME`.

The NixOS / nix-darwin system configuration for the owner's machines and servers
lives in a separate private repository (`../infra`).

## Common Commands

```bash
./deploy                 # no args: print usage and exit
./deploy default         # symlink the core dotfiles into $HOME
./deploy desktop         # link GUI/terminal configs (ghostty, systemd user units)
./deploy skills [name]   # symlink Claude skills into ~/.claude/skills/ (all, or one named)
./deploy private         # run private/deploy (git-crypt encrypted secrets)
./deploy deps            # brew bundle (installs packages from ./Brewfile)

./push <host>            # rsync this repo to <host>:code/conf/dotfiles/ (respects .gitignore)
```

## Architecture

### Dotfile deployment (`deploy`)
`deploy` is a Bash script driven by `files_default` / `files_desktop` arrays of
`src:dst` pairs. `install_filepair` symlinks each `src` (repo-relative) to `dst`
(`$HOME`-relative), replacing existing symlinks but refusing to overwrite real files.
To add a dotfile, add a `src:dst` entry to the appropriate array — do not write to
`$HOME` directly. Note dotfiles land in non-obvious places (e.g. `git/gitconfig` →
`~/.gitconfig`, `fish/config.fish` → `~/.config/fish/config.fish`).

### Private / encrypted content
- Secrets live under `private/`, encrypted with **git-crypt** (see `.git-crypt/`,
  GPG key). Without the key these files are opaque blobs. `deploy private` runs
  `private/deploy` to symlink them into place.

### Other components
- `nvim/` — Neovim config (`init.vim` + `lua/`, lazy.nvim plugins under `lua/plugins/`).
- `bin/` — personal scripts, symlinked onto `$PATH` via the `.dotfiles` link.
- Terminal/shell configs: `fish/`, `tmux`, `starship.toml`, `ghostty/`.

## Conventions
- Shell scripts use `#!/usr/bin/env bash` with `set -eu`; `.shellcheckrc` is deployed.
