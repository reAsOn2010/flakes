{ config, lib, pkgs, ... }:
let
  vpnctl = pkgs.writeShellScriptBin "vpnctl" (builtins.readFile ./vpnctl);
  lock = pkgs.writeShellScriptBin "lock" ''exec swaylock'';
  dlwallpaper = pkgs.writeShellScriptBin "dlwallpaper" (builtins.readFile ./dlwallpaper);
in
{
  home.packages = with pkgs; [
    vpnctl
    lock
    dlwallpaper
  ];
}
