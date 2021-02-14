self: super:

let
  perlDeps = with self.perlPackages; [
      ArchiveZip
      NetSSLeay
      XMLLibXML
      HTMLParser
      JSON
      JSONXS
      DigestSHA1
    ];
in {
  irssi-autodl = super.irssi.overrideAttrs (old: rec {
    nativeBuildInputs = old.nativeBuildInputs ++ [ self.makeWrapper ];

    postFixup = ''
      wrapProgram "$out/bin/irssi" --set PERL5LIB " ${self.perlPackages.makeFullPerlPath perlDeps}"
    '';
  });
}
