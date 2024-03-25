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
    unstable.ueberzugpp
    unstable.yazi
    rustdesk
    keepassxc
    nix-index # nix-locate
    ffmpeg
    dbeaver
    kubectl
    # kubeconform
    mongodb-compass
    silver-searcher # ag
    sxiv # image viewer
    at
    fastfetch
    conky
    skopeo

    # develop tools
    jetbrains.idea-community
    adoptopenjdk-bin
    jetbrains.pycharm-community
    jetbrains.goland
    python311
    jetbrains.clion
    unstable.obsidian
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
    unstable.safeeyes
    workrave
    maven
    peazip
    # unstable.wavebox
    # unstable.franz
    unstable.rambox

    # cloud storage
    rclone


    # NUR
    config.nur.repos.xddxdd.wechat-uos
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
    };
  };
}
