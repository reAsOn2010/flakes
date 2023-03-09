{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swayidle
  ];
  home.file."${config.xdg.configHome}/swayidle/config" = {
    source = ./config;
  };
}
