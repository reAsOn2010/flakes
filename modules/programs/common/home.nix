{ config, pkgs, unstable, inputs, ... }:
{
  imports = [
    ../alacritty/home.nix
    ../shell/home.nix
    ../browser/home.nix
    ../vim/home.nix
    ../vscode/home.nix
    ../scripts/home.nix
    # ../fish/home.nix
    ../zsh/home.nix
    # ../wps/home.nix
    ../libreoffice/home.nix
    ../mpd/home.nix
    # ../dochat/home.nix
    # ../ranger/home.nix
    # ../vifm/home.nix
    ../wayvnc/home.nix
    ../syncthing/home.nix
  ];

  home.packages = with pkgs; [
    # common programs
    cinnamon.nemo
    rustdesk
    enpass
    keepassxc
    nix-index # nix-locate
    ffmpeg
    yq-go # yaml formatter
    dbeaver
    kubectl
    mongodb-compass
    silver-searcher # ag
    sxiv # image viewer


    # develop tools
    jetbrains.idea-community
    adoptopenjdk-bin
    jetbrains.pycharm-community
    python310
    jetbrains.clion
    obsidian
    zotero
    gcc
    cmake
    gnumake
    go
    nixpkgs-fmt
    nodejs
    nodePackages.npm
    mattermost-desktop
    genymotion
    safeeyes
    maven
    unstable.peazip
    # unstable.wavebox
    unstable.franz
    unstable.rambox

    # cloud storage
    rclone
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
    };
  };
}
