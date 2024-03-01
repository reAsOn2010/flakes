{ config, pkgs, ... }:
{
  services.mako = {
    enable = true;
    font = "monospace 12";
    width = 400;
    height = 600;
    backgroundColor = "#${config.colorScheme.colors.base01}FF";
    textColor = "#${config.colorScheme.colors.base04}FF";
    borderColor = "#${config.colorScheme.colors.base00}FF";
    progressColor = "over #${config.colorScheme.colors.base08}FF";
    defaultTimeout = 60000;
    borderRadius = 5;
    ignoreTimeout = true;
    format = "<b>%s</b> <span color=\"#93a1a1\">(%a)</span>\\n%b";
  };
}
