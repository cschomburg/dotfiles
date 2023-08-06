{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  #inputs.nixpkgs.url = "nixpkgs/872fceeed60";

  inputs.neovim-nightly-overlay = {
    url = "github:nix-community/neovim-nightly-overlay";
    # Pin to a nixpkgs revision that doesn't have NixOS/nixpkgs#208103 yet
    # https://github.com/nix-community/neovim-nightly-overlay/issues/164
    #inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
  };

  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.prophecy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ({
          /* nixpkgs.overlays = [ attrs.neovim-nightly-overlay.overlay ]; */
        })
      ];
    };
  };
}
