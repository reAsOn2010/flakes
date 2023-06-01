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
    ../vifm/home.nix
  ];

  home.packages = with pkgs; [
    adoptopenjdk-bin
    firefox
    unstable.rustdesk
    jetbrains.idea-community
    jetbrains.pycharm-community
    jetbrains.clion
    python310
    go
    nixpkgs-fmt
    dbeaver
    enpass
    kubectl
    silver-searcher
    mongodb-compass
    # not wayland compatible
    # synergy
    nodejs
    nodePackages.npm
    gcc
    cmake
    gnumake
    cinnamon.nemo
    nix-index

    ffmpeg

    yq-go
  ];

}
