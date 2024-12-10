{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2" # nixd depends on it
    "electron-19.1.9" # wechat-uos depends on it
    "openssl-1.1.1w" # wechat-uos depends on it
  ];

  time.timeZone = "Asia/Shanghai";
  time.hardwareClockInLocalTime = true;
  # time.hardwareClockInLocalTime = false;
  networking = {
    networkmanager.enable = true;
    hosts = {
      "10.222.252.1" = [ "cls-aivkqtcv.ccs.tencent-cloud.com" ];
      "10.233.252.1" = [ "cls-mhktarmn.ccs.tencent-cloud.com" ];
    };
  };
  networking.firewall.allowedUDPPorts = [ 80 443 8000 8080 21118 ];
  networking.firewall.allowedTCPPorts = [ 80 443 8000 8080 21118 ];
  services = {
    openssh = {
      enable = true;
    };
    dbus = {
      enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    atd = {
      enable = true;
    };
    blueman.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    sane = {
      enable = true;
      extraBackends = [ pkgs.hplipWithPlugin ];
    };
  };
  security.rtkit.enable = true;
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      stdenv.cc.cc.lib
      git
      wget
      p7zip
      zip
      unzipNLS
      killall
      socat
      rar
      jq
      patchelf
      zlib
      pamixer
      socat
      inputs.agenix.packages.x86_64-linux.agenix
      pinentry-qt
    ];
  };
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    # package = pkgs.nixVersions.unstable;
    # registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs          = true
      keep-derivations      = true
    '';
  };
  system = {
    autoUpgrade = {
      enable = false;
      channel = "https://nixos.org/channels/nixos-24.11";
    };
    stateVersion = "24.11";
  };
}
