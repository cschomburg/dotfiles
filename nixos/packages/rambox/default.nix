{ pkgs ? import <nixpkgs> {} }:

with pkgs;
with pkgs.stdenv;

let
  pname = "rambox";
  version = "2.0.6";
  name = "${pname}-${version}";
  appname = "Rambox";

  src = fetchurl {
    url = "https://github.com/ramboxapp/download/releases/download/v${version}/Rambox-${version}-linux-x64.AppImage";
    sha256 = "sha256-UCdeWMUWRVmmu0I9cVt8A7HSVKzI5it70USaT4aUayg=";
  };

  desktopItem = (makeDesktopItem {
    desktopName = appname;
    name = pname;
    exec = pname;
    icon = pname;
    categories = [ "Network" ];
  });

in appimageTools.wrapType2 rec {
  inherit name src;
  profile = ''
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  extraInstallCommands =
    let appimageContents = appimageTools.extractType2 { inherit name src; };
    in ''
      mkdir -p $out/share/applications $out/share/icons/hicolor/256x256/apps
      mv $out/bin/rambox* $out/bin/${pname}
      install -Dm644 ${appimageContents}/usr/share/icons/hicolor/256x256/apps/rambox*.png $out/share/icons/hicolor/256x256/apps/${pname}.png
      install -Dm644 ${desktopItem}/share/applications/* $out/share/applications
    '';

  meta = with lib; {
      description = "Messaging and emailing app that combines common web applications into one";
      homepage = "https://rambox.app";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
  };
}
