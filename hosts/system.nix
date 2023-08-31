{ config, pkgs, lib, inputs, user, ... }:

{
  nixpkgs.system = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;

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
  networking.firewall.allowedUDPPorts = [ 80 443 8000 8080 ];
  networking.firewall.allowedTCPPorts = [ 80 443 8000 8080 ];
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
      nssmdns = true;
      openFirewall = true;
    };
  };
  security.rtkit.enable = true;
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      git
      wget
      p7zip
      zip
      unzip
      killall
      socat
      rar
      jq
      patchelf
      zlib
      pamixer
      socat
      inputs.agenix.packages.x86_64-linux.agenix
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
      channel = "https://nixos.org/channels/nixos-23.05";
    };
    stateVersion = "23.05";
  };
}