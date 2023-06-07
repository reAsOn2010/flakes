{ config, pkgs, unstable, inputs, ... }:
{
  imports = [
    ../alacritty/home.nix
    ../shell/home.nix
    ../firefox/home.nix
    ../vim/home.nix
    ../vscode/home.nix
    ../scripts/home.nix
    ../fish/home.nix
    # ../wps/home.nix
    ../libreoffice/home.nix
    ../mpd/home.nix
    # ../dochat/home.nix
    # ../ranger/home.nix
    # ../vifm/home.nix
  ];

  home.packages = with pkgs; [
    # common programs
    cinnamon.nemo
    rustdesk
    enpass
    nix-index # nix-locate
    ffmpeg
    yq-go # yaml formatter
    dbeaver
    kubectl
    mongodb-compass
    silver-searcher # ag
    marktext # markdown editor
    sxiv # image viewer
    # develop tools
    jetbrains.idea-community
    adoptopenjdk-bin
    jetbrains.pycharm-community
    python310
    jetbrains.clion
    gcc
    cmake
    gnumake
    go
    nixpkgs-fmt
    nodejs
    nodePackages.npm
  ];

}
