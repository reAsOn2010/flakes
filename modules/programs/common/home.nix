{ config, pkgs, ... }:
{
  imports = [
    ../alacritty/home.nix
    ../shell/home.nix
    ../firefox/home.nix
    ../vim/home.nix
    ../vscode/home.nix
    ../scripts/home.nix
    ../fish/home.nix
    ../wps/home.nix
    ../mpd/home.nix
  ];

  home.packages = with pkgs; [
    adoptopenjdk-bin
    firefox
    rustdesk
    jetbrains.idea-community
    jetbrains.pycharm-community
    python310
    go
    nixpkgs-fmt
    dbeaver
    enpass
    kubectl
    silver-searcher
    mongodb-compass
    synergy
  ];

}
