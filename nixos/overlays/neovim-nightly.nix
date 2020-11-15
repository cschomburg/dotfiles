self: super:

{
  # https://github.com/mjlbach/neovim-nightly-overlay
  tree-sitter-updated = super.tree-sitter.overrideAttrs(oldAttrs: {

    version = "0.17.3";
    sha256 = "sha256-uQs80r9cPX8Q46irJYv2FfvuppwonSS5HVClFujaP+U=";
    cargoSha256 = "sha256-fonlxLNh9KyEwCj7G5vxa7cM/DlcHNFbQpp0SwVQ3j4=";

    postInstall = ''
      PREFIX=$out make install
    '';
  });

  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-nightly";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0a95549d66df63c06d775fcc329f7b63cbb46b2f";
      sha256 = "0a54xjd31dvz32hkzc8qhjnnp6g7v3npk5a5bdnlzh2mhxjnqyl4";
    };

    buildInputs = old.buildInputs ++ [ self.utf8proc ];
    nativeBuildInputs = with self.pkgs; [ unzip cmake pkgconfig gettext tree-sitter-updated ];
  });
}
