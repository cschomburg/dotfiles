self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "2538e615130c7f4baa1029d0be2bc2d7f66cdd7e";
      sha256 = "096ywfzhifkdlgym8zn4ch2cpg26phg831mkmalf9qxm6lbm3yfd";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
