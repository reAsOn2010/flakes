{ config, pkgs, ... }:
{
  programs.steam = {
    emable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}