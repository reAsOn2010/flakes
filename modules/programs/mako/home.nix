{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    font = "monospace 12";
    width = 400;
    height = 600;
    backgroundColor = "#${config.colorScheme.palette.base01}FF";
    textColor = "#${config.colorScheme.palette.base04}FF";
    borderColor = "#${config.colorScheme.palette.base00}FF";
    progressColor = "over #${config.colorScheme.palette.base08}FF";
    defaultTimeout = 60000;
    borderRadius = 5;
    ignoreTimeout = true;
    format = "<b>%s</b> <span color=\"#93a1a1\">(%a)</span>\\n%b";
  };
}
