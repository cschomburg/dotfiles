self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "234232ff4e4b0885485de1054cd5c09897015d6a";
      sha256 = "1pp80kclaaa1r73inyvd4nj6w5a77s65bgzhskkrpxyv6dnqwj8l";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
