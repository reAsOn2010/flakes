{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ranger
  ];
  nixpkgs.overlays = [
    (final: prev: {
      ranger =
        prev.ranger.overrideAttrs (oldAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "ranger";
            repo = "ranger";
            rev = "96e9063399f3e620ba98300803598557b90b2a5b";
            sha256 = "sha256-6/Ygz29G+tfkseyC0i/BMU7mo3PsiyugBsbh/HsRnHM=";
          };
          propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ]) ++ [
            pkgs.python313Packages.astroid
            pkgs.python313Packages.pylint
          ];
        });
    })
  ];
}
