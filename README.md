# dotfiles

My user & system configuration.

Quickstart:
```bash
git clone https://github.com/xconstruct/dotfiles && cd dotfiles
./deploy desktop
```

Or without Git:
```bash
mkdir dotfiles && curl -L https://github.com/xconstruct/dotfiles/tarball/master | tar -xzv --strip-components 1 -C dotfiles && cd dotfiles
./deploy
```

The complete configuration of all my devices and servers is also included here, thanks to [NixOS](https://nixos.org).
To get started, create a machine profile with your hostname similar to [nixos/machines/paragon.nix](nixos/machines/paragon.nix).

```bash
cd dotfiles/nixos && ./rebuild
```

## Shoutouts

Thanks to all of these amazing tools:

- [NixOS](https://nixos.org/) & [nix-darwin](https://github.com/LnL7/nix-darwin)
- [Neovim](https://neovim.io/)
- [Fish](https://fishshell.com/)
- [fzf](https://junegunn.github.io/fzf/)
- [Starship](https://starship.rs/)
- [Zoxide](https://github.com/ajeetdsouza/zoxide)
- [Atuin](https://atuin.sh/)
- [Ghostty](https://ghostty.org/)
