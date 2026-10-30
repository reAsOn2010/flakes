{ config, pkgs, inputs, user, hostName, ... }:
let
in
{
  imports = [
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/common/home.nix
    # overlays 已在 hosts/home/default.nix 的 NixOS 层应用，useGlobalPkgs 下 home-manager
    # 复用系统 pkgs，这里再写一次会触发 “nixpkgs.overlays + useGlobalPkgs” 警告
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
  home.stateVersion = "26.05";
}

