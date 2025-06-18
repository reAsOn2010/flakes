{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    settings = {
      font = "monospace 12";
      width = 400;
      height = 600;
      background-color = "#${config.colorScheme.palette.base00}FF";
      text-color = "#${config.colorScheme.palette.base05}FF";
      border-color = "#${config.colorScheme.palette.base0C}FF";
      progress-color = "over #${config.colorScheme.palette.base07}FF";
      default-timeout = 10000;
      border-radius = 5;
      ignore-timeout = 1;
      format = "<b>%s</b><span color=\"#${config.colorScheme.palette.base06}\">(%a)</span>\\n%b";
    };
  };
}
