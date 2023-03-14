{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Shanghai";
  networking = {
    networkmanager.enable = true;
    hosts = {
      "10.222.252.1" = [ "cls-aivkqtcv.ccs.tencent-cloud.com" ];
      "10.233.252.1" = [ "cls-mhktarmn.ccs.tencent-cloud.com" ];
    };
  };
  services = {
    openssh = {
      enable = true;
    };
    dbus = {
      enable = true;
    };
  };
  security.rtkit.enable = true;
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      git
      wget
      p7zip
      zip
      unzip
      killall
      socat
      rar
      cinnamon.nemo
      jq
      patchelf
    ];
  };
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://hyprland.cachix.org"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-unstable";
    };
    stateVersion = "22.11";
  };
}
