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
        epstopdf
        latexmk;
    })

    (myEnvFun {
      name = "scientific-python";
      buildInputs = with python34Packages; [
        python
        ipython
        jupyter
        matplotlib
        numpy
        pandas
        scipy
        seaborn
      ];
    })

  ];
}
