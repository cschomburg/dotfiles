{ config, lib, pkgs, ... }:

let
  rancher-cli = pkgs.callPackage ../packages/rancher-cli.nix {};
  helm2 = pkgs.callPackage ../packages/helm2.nix {};
in {
  environment.systemPackages = with pkgs; [
    helm2
    jq
    k9s
    kube3d
    kubectl
    kubectx
    rancher-cli
  ];
}
