self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-nightly";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "c348e816fc530f185d799270ad3c39bd0d6799a6";
      sha256 = "1dlrrc27sczlav5ap79za9qa55w2r8sf8747xzffgkqrd34g91pw";
    };

    buildInputs = old.buildInputs ++ [ self.tree-sitter ];
  });
}
