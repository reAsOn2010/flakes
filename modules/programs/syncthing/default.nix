{ config, lib, pkgs, user, ... }:

{
  services.syncthing = {
    enable = false;
    user = "${user}";
    dataDir = "/home/${user}/Sync";
    configDir = "/home/${user}/.config/syncthing";
    # overrideFolders = true;
    # devices = {
    #   "oneplus8p" = { id = "A6LCNPC-BMEOIU7-HPYUKSX-XEYDQ2S-MXZY57Z-P5SDKFK-57YMFA5-FG52KAZ"; };
    # };
    # folders = {
    #   "八云的同步文件夹" = {
    #     path = "/home/${user}/Sync";
    #     devices = [ "oneplus8p" ];
    #   };
    # };
  };
  # networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  # networking.firewall.allowedUDPPorts = [ 22000 21027 ];
}

