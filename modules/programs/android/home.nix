{ config, pkgs, unstable, inputs, ... }:
{
  home.packages = with pkgs; [
    genymotion  
  ];
}
