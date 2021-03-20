# dotfiles

My user & system configuration.

Quickstart:
```bash
git clone https://github.com/xconstruct/dotfiles && cd dotfiles
./deploy desktop z fzf
```

Or without Git:
```bash
mkdir dotfiles && curl -L https://github.com/xconstruct/dotfiles/tarball/master | tar -xzv --strip-components 1 -C dotfiles && cd dotfiles
./deploy
```

The complete configuration of all my devices and servers is also included here, thanks to [NixOS](https://nixos.org).
To get started, create a machine profile with your hostname similar to [nixos/machines/codex.nix](nixos/machines/codex.nix).

```bash
echo -n $(hostname) > /etc/nixos/hostname
cd dotfiles/nixos && ./rebuild
