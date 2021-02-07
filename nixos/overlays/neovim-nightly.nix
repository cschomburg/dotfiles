self: super:

{
  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (old: rec {
    name = "neovim-unwrapped-${version}";
    version = "0.5.0-nightly";

    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "0efbab5f5e670ca33ea4d0ed20d9702aab8d7de1";
      sha256 = "0znrazvsfrma9lv214czmfa0xmrv32abq4yqw7srkzspfb7yk3dc";
    };

    buildInputs = old.buildInputs ++ [ self.tree-sitter ];
  });
}
