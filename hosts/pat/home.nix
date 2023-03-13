{ config, pkgs, inputs, user, hostName, ... }:
let
in
{
  imports = [
    ( import ../../modules/desktop/hyprland/home.nix )
    ( import ../../modules/programs/common/home.nix )
  ] ++ [

  ];
  colorScheme = inputs.nix-colors.colorSchemes.default-dark;
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