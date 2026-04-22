{ config, pkgs, ... }:
{
  home.file."${config.xdg.configHome}/ashell/config.toml" = {
    source = ./config.toml;
  };
}
