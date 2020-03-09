self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "49cd750d6a72efc0571a89d7a874bbb01081227f";
      sha256 = "07mivpjlpc9mcz2cljd85bhy2lkbgb4frxbjaja5s7ww6c3vszmx";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
