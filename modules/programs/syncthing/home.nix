{ config, pkgs, user, ... }:

{
  services.syncthing = {
    enable = true;
  };
  home.packages = [
    pkgs.syncthingtray-minimal
  ];
}
