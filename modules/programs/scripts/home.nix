{ config, lib, pkgs, ... }:
let
  vpnctl = pkgs.writeShellScriptBin "vpnctl" (builtins.readFile ./vpnctl);
  lock = pkgs.writeShellScriptBin "lock" ''exec swaylock'';
  dlwallpaper = pkgs.writeShellScriptBin "dlwallpaper" ''
    mkdir -p ${config.xdg.configHome}/wallpapers
    for ((i=0; i < 10; i++))
    do
    	curl -Lo "${config.xdg.configHome}/wallpapers/wallpaper$i.jpg https://source.unsplash.com/1920x1080/?city,night,ocean,space
    done
  '';
in
{
  home.packages = with pkgs; [
    vpnctl
    lock
  ];
}
