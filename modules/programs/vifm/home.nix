{ config, pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    vifm-full
    sxiv
  ];
  home.file."${config.xdg.configHome}/vifm/vifmrc" = {
    source = ./vifmrc;
  };
}

