self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-nightly";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0ab88c2ea80caa7cda97b3a8479d0d32e4636ab6";
      sha256 = "07jiv9c3032lrhmd3dvqv2v5l35bdn39jqi48qsjj220slrsrl53";
    };

    buildInputs = old.buildInputs ++ [ self.tree-sitter ];
  });
}
