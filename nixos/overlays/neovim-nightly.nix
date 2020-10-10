self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "ce5a260c9ec5c85eb67eef268e3138b11da86224";
      sha256 = "1z0k7sdb72z43r4kjz6j72fbag7lfj5saa6jjz1m9lnda11x0jik";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
