{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    font = "monospace 12";
    width = 400;
    height = 600;
    backgroundColor = "#${config.colorScheme.palette.base00}FF";
    textColor = "#${config.colorScheme.palette.base05}FF";
    borderColor = "#${config.colorScheme.palette.base0C}FF";
    progressColor = "over #${config.colorScheme.palette.base07}FF";
    defaultTimeout = 60000;
    borderRadius = 5;
    ignoreTimeout = true;
    format = "<b>%s</b><span color=\"#${config.colorScheme.palette.base06}\">(%a)</span>\\n%b";
  };
}
