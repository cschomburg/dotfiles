{ config, lib, pkgs, ... }:

{

  nixpkgs.config.packageOverrides = pkgs: rec {
    texliveCombined = 
      (pkgs.texlive.combine {
        inherit (pkgs.texlive)
          scheme-basic
          collection-fontsrecommended
          collection-langgerman
          collection-latexrecommended
          collection-latexextra
          epstopdf
          latexmk;
      });

    scientificPython =
     (pkgs.myEnvFun {
       name = "scientific-python";
       buildInputs = with pkgs.python34Packages; [
         python
         ipython
         jupyter
         matplotlib
         numpy
         pandas
         scipy
         seaborn
       ];
     });
  };

  environment.systemPackages = with pkgs; [
    texliveCombined
  ];
}
