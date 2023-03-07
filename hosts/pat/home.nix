{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ [

  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "22.11";
}