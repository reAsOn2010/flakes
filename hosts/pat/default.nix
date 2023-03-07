{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ [

  ];
  boot = {
    supportedFilesystems = [ "ntfs" ];
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 3;
    };
    kernelParams = [
      "quiet"
      "splash"
      # "systemd.unified_cgroup_hierarchy=0"  # if need cgroups v1
    ];
    # consoleLogLevel = 0;
    # initrd.verbose = false;
  };
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-pinyin-zhwiki
    ];
  };
  users.mutableUsers = false;
  users.groups.lrun = {
    gid = 593;
  };
  users.users.${user} = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "lrun" "docker" "libvirtd" "video" "audio" ];
    passwordFile = config.age.secrets."yakumo/hashed-password".path;
    # openssh.authorizedKeys.keyFiles = [./secrets/users/yakumo/yakumo.pub];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn the.reason.sake@gmail.com"
    ];
  };
  environment = {
    systemPackages = with pkgs; [
      libnotify
      wl-clipboard
      wayland
      wayland-utils
      xwayland
      qt6.qtwayland
      libsForQt5.qt5.qtwayland
      cinnamon.nemo
      networkmanagerapplet
      grim
    ];
  };
  services = {
    getty.autologinUser = "${user}";
  };
  security = {
    polkit.enable = true;
    sudo = {
      enable = true;
      extraConfig = ''
        ${user} ALL=(ALL) NOPASSWD:ALL
      '';
    };
  };
}
