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
    ../fcitx5/home.nix
  ];

  home.packages = with pkgs; [
    # common programs
    nemo
    unstable.ueberzugpp
    unstable.yazi
    # rustdesk
    keepassxc
    # bitwarden-desktop
    nix-index # nix-locate
    ffmpeg
    dbeaver-bin
    kubectl
    kubernetes-helm
    krita
    # kubeconform
    mongodb-compass
    silver-searcher # ag
    sxiv # image viewer
    at
    fastfetch
    conky
    skopeo

    # develop tools
    jetbrains.idea-ultimate
    # openjdk11-bootstrap
    openjdk17-bootstrap
    jetbrains.pycharm-professional
    jetbrains.goland
    python311
    jetbrains.clion
    gcc
    cmake
    gnumake
    go
    nixpkgs-fmt
    nodejs
    nodePackages.npm
    mattermost-desktop
    maven
    xarchiver
    pinentry
    protobuf
    protoc-gen-go
    protoc-gen-go-grpc
    unstable.rambox
    marktext
    bruno
    opentofu
    terraformer
    terragrunt
    cobang
    wireguard-tools
    dig

    # cloud storage
    rclone

    # bt client
    deluge

    # NUR
    nur.repos.xddxdd.wechat-uos-without-sandbox
    nur.repos.xddxdd.baidunetdisk
    nur.repos.xddxdd.dingtalk
    xdg-user-dirs
    # config.nur.repos.linyinfeng.rimePackages.rime-ice
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "nemo.desktop" ];
    };
  };

  homeage = {
    file."idea64.vmoptions" = {
      source = ../../../secrets/yakumo/jetbrains/vmoptions.age;
      copies = [ "${config.xdg.configHome}/JetBrains/IntelliJIdea2024.1/idea64.vmoptions" ];
      mode = "0600";
    };
    file."pycharm64.vmoptions" = {
      source = ../../../secrets/yakumo/jetbrains/vmoptions.age;
      copies = [ "${config.xdg.configHome}/JetBrains/PyCharm2024.1/pycharm64.vmoptions" ];
      mode = "0600";
    };
    file."goland64.vmoptions" = {
      source = ../../../secrets/yakumo/jetbrains/vmoptions.age;
      copies = [ "${config.xdg.configHome}/JetBrains/GoLand2024.1/goland64.vmoptions" ];
      mode = "0600";
    };
    file."clion64.vmoptions" = {
      source = ../../../secrets/yakumo/jetbrains/vmoptions.age;
      copies = [ "${config.xdg.configHome}/JetBrains/CLion2024.1/clion64.vmoptions" ];
      mode = "0600";
    };
  };

}
