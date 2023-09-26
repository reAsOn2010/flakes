{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    cliphist # clipboard manager
    wl-clipboard # clipboard
  ];
}
