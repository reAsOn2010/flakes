{ config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./version.nix
    ./user.nix
    ./display.nix
  ];
  nix.binaryCaches = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}