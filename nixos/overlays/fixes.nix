self: super:

{
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
}
