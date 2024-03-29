{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaylock-effects
  ];

  home.file."${config.xdg.configHome}/swaylock/config".text = ''
    screenshots
    clock
    ignore-empty-password
    indicator
    indicator-radius=100
    indicator-thickness=7
    effect-blur=7x5
    effect-vignette=0.5:0.5
    ring-color=${config.colorScheme.palette.base04}
    ring-ver-color=${config.colorScheme.palette.base07}
    ring-wrong-color=${config.colorScheme.palette.base08}
    ring-clear-color=${config.colorScheme.palette.base09}
    key-hl-color=${config.colorScheme.palette.base0C}
    line-color=${config.colorScheme.palette.base00}
    inside-color=${config.colorScheme.palette.base01}
    inside-ver-color=${config.colorScheme.palette.base07}
    inside-wrong-color=${config.colorScheme.palette.base08}
    inside-clear-color=${config.colorScheme.palette.base09}
    separator-color=${config.colorScheme.palette.base00}
    text-color=${config.colorScheme.palette.base04}
    fade-in=0.3
  '';
  # programs.swaylock.enable = true;
  # programs.swaylock.settings = {
  #   screenshots = true;
  #   clock = true;
  #   ignore-empty-password = true;
  #   indicator = true;
  #   indicator-radius = 100;
  #   indicator-thickness = 7;
  #   effect-blur = "7x5";
  #   effect-vignette = "0.5:0.5";
  #   ring-color = "${config.colorScheme.palette.base04}";
  #   ring-ver-color = "${config.colorScheme.palette.base07}";
  #   ring-wrong-color = "${config.colorScheme.palette.base08}";
  #   ring-clear-color = "${config.colorScheme.palette.base09}";
  #   key-hl-color = "${config.colorScheme.palette.base0C}";
  #   line-color = "${config.colorScheme.palette.base00}";
  #   inside-color = "${config.colorScheme.palette.base01}";
  #   inside-ver-color = "${config.colorScheme.palette.base07}";
  #   inside-wrong-color = "${config.colorScheme.palette.base08}";
  #   inside-clear-color = "${config.colorScheme.palette.base09}";
  #   separator-color = "${config.colorScheme.palette.base00}";
  #   text-color = "${config.colorScheme.palette.base04}";
  #   # grace = 2;
  #   fade-in = 0.3;
  # };
}
