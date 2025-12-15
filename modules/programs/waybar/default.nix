{ config, lib, pkgs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    waybar
  ];
}
