{ config, lib, pkgs, ... }:

let
  rancher-cli = pkgs.callPackage ../packages/rancher-cli.nix {};
  helm2 = pkgs.callPackage ../packages/helm2.nix {};
in {
  environment.systemPackages = with pkgs; [
    kubernetes-helm
    helm2
    jq
    jsonnet
    k9s
    kube3d
    kubectl
    kubie
    #rancher-cli
    sops
    terraform
    vault
  ];
}
