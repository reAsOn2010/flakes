{ config, pkgs, ... }:
{
  # programs.firefox.enable = true;
  home.packages = with pkgs; [
    microsoft-edge
  ];
}

