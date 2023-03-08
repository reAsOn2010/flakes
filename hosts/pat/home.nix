{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ( import ../../modules/desktop/home.nix )
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
  manual.manpages.enable = false;
}