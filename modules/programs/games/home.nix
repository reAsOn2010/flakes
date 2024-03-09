{ config, pkgs, unstable, inputs, ... }:
{
  home.packages = with pkgs; [
    unstable.ryujinx
    unstable.joycond
    unstable.joycond-cemuhook
  ];
}
