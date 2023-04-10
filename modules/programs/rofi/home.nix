{ config, pkgs, ... }:
let
  rofi-launcher = pkgs.writeShellScriptBin "rofi-launcher" ''
    #!/usr/bin/env bash
    rofi -show drun
  '';
  rofi-power = pkgs.writeShellScriptBin "rofi-power" ''
    #!/usr/bin/env bash
    all=(lock shutdown reboot)
    cmd=''$(printf '%s\n' "''${all[@]}" | rofi -dmenu)
    exec ''$cmd
  '';
in
{
  home.packages = with pkgs; [
    rofi-wayland
    rofi-calc
    rofi-systemd
    rofi-emoji
    # self scripts
    rofi-launcher
    rofi-power
  ];
  home.file."${config.xdg.configHome}/rofi/config.rasi" = {
    source = ./config.rasi;
  };
  home.file."${config.xdg.dataHome}/rofi/themes" = {
    source = ./themes;
  };
}
