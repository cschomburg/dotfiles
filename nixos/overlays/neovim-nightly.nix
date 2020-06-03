self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-dev";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "e9cc383614d449b7269632c991525db77c387154";
      sha256 = "1p87h9h4ycyx07qil5cg5kdm4bv8virb0aic6m5fky8qqpa5900s";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
  });
}
