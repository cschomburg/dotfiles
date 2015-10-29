{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (texlive.combine {
      inherit (texlive)
        scheme-basic
        collection-fontsrecommended
        collection-langgerman
        collection-latexrecommended
        collection-latexextra
        latexmk;
    })
  ];
}
