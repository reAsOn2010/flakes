{ config, pkgs, unstable, inputs, ... }:
{
  # home.packages = with pkgs; [
  #   genymotion  
  # ];
  home.packages = with pkgs; [
    nur.repos.ataraxiasjel.waydroid-script
  ];
}
