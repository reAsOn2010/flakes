{ config, pkgs, unstable, ... }:
{
  home.packages = with pkgs; [
    cherry-studio
    unstable.playwright-mcp
  ];
}
