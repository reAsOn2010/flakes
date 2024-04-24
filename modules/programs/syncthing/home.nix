{ config, pkgs, user, ... }:

{
  services.syncthing = {
    enable = false;
  };
  home.packages = [
    # pkgs.syncthingtray-minimal
  ];
}
