{ config, pkgs, inputs, user, hostName, ... }:
let
in
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/common/home.nix
    ../../modules/overlays/overlays.nix
    ../../modules/programs/games/home.nix
    ../../modules/programs/android/home.nix
  ];
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-latte;
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "25.05";
}

