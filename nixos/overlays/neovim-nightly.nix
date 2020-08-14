self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "f26df8bb66158baacb79c79822babaf137607cd6";
      sha256 = "0ci5bgkw1j4gr2pls84q3vgn859zwwxfnr3wnyqaj5hyimr9yz6h";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
