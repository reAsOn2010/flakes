{ config, pkgs, inputs, user, hostName, ... }:
let
in
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/common/home.nix
    ../../modules/overlays/overlays.nix
    ../../modules/programs/games/home.nix
  ];
  colorScheme = inputs.nix-colors.colorSchemes.default-dark;
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
  };
  programs = {
    home-manager.enable = true;
  };
  home.stateVersion = "24.05";
}

