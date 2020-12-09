self: super:

let
  fixedurl = builtins.fetchurl https://raw.githubusercontent.com/NixOS/nixpkgs/f0250226b279983c07cc33c06d0309903dfc1df9/pkgs/applications/terminal-emulators/alacritty/default.nix;
in {
  # dbeaver = super.dbeaver.overrideAttrs (old: rec {
  #   src = super.fetchurl {
  #     url = "https://dbeaver.io/files/${old.version}/dbeaver-ce-${old.version}-linux.gtk.x86_64.tar.gz";
  #     sha256 = "1fnvwndzny51z0zmdnlafdcxawsyz435g712mc4bjjj29qy0inzm";
  #   };
  # });

  linuxPackagesFor = kernel:
    (super.linuxPackagesFor kernel).extend (self': super': {
      v4l2loopback = super'.v4l2loopback.overrideAttrs (old: rec {
        src = super.fetchFromGitHub {
          owner = "umlaeute";
          repo = "v4l2loopback";
          rev = "0569340b0dfd85cbb26d4dabf8051cae461af443";
          sha256 = "18yw4q44c9ayn3k2bdmf63dchc9ndxdpfslvzd2gkhzrz1v319rw";
        };
      });
  });

  # https://github.com/NixOS/nixpkgs/pull/103817
  # alacritty = self.callPackage (import fixedurl) {
  #   inherit (self.xorg) libXcursor libXxf86vm libXi;
  #   inherit (self.darwin.apple_sdk.frameworks) AppKit CoreGraphics CoreServices CoreText Foundation OpenGL;
  # };
}
