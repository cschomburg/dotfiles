{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.05";
  inputs.nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  #inputs.nixpkgs.url = "nixpkgs/872fceeed60";

  inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@attrs: {
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

      ghostwarden = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ ./configuration.nix ];
      };
    };
  };
}
