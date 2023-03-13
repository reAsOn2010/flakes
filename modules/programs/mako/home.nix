{ config, pkgs, ... }:
{
  programs.mako = {
    enable = true;
    backgroundColor = "#${config.colorScheme.colors.base01}FF";
    textColor = "#${config.colorScheme.colors.base04}FF";
    borderColor = "#${config.colorScheme.colors.base00}FF";
    progressColor = "#${config.colorScheme.colors.base08}FF";
    defaultTimeout = 300000;
    borderRadius = 5;
  };
}