{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    #nixpkgs.url = "nixpkgs/872fceeed60";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, ... }@attrs: {
    nixosConfigurations = {
      prophecy = nixpkgs-unstable.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          ({
            /* nixpkgs.overlays = [ attrs.neovim-nightly-overlay.overlay ]; */
          })
        ];
      };

      aspect = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          (nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
        ];
      };

      citadel = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./configuration.nix
        ];
      };

      ghostwarden = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ ./configuration.nix ];
      };
    };

    darwinConfigurations = {
      paragon = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = attrs;
        modules = [
          ./machines/paragon.nix
        ];
      };
    };
  };
}
