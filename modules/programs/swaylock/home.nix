{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaylock-effects
  ];

  programs.swaylock.settings = {
    screenshots = true;
    clock = true;
    ignore-empty-password = true;
    indicator = true;
    indicator-radius = 100;
    indicator-thickness = 7;
    effect-blur = "7x5";
    effect-vignette = "0.5:0.5";
    ring-color = "${config.colorScheme.colors.base04}";
    ring-ver-color = "${config.colorScheme.colors.base07}";
    ring-wrong-color = "${config.colorScheme.colors.base08}";
    ring-clear-color = "${config.colorScheme.colors.base09}";
    key-hl-color = "${config.colorScheme.colors.base0C}";
    line-color = "${config.colorScheme.colors.base00}";
    inside-color = "${config.colorScheme.colors.base01}";
    inside-ver-color = "${config.colorScheme.colors.base07}";
    inside-wrong-color = "${config.colorScheme.colors.base08}";
    inside-clear-color = "${config.colorScheme.colors.base09}";
    separator-color = "${config.colorScheme.colors.base00}";
    text-color = "${config.colorScheme.colors.base04}";
    # grace = 2;
    fade-in = 0.3;
  };
}
