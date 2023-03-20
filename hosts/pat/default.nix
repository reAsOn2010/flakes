{ config, pkgs, inputs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ [
    ../../modules/desktop/hyprland
    ../../modules/programs/openvpn
    ../../modules/programs/fonts
    ../../modules/programs/waybar
    ../../modules/programs/steam
    ../../modules/programs/fish
    ../../modules/virtualisation
  ];
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
  ];
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
  networking.firewall.allowedTCPPorts = [
    80
    443
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

  users.mutableUsers = false;
  users.groups.lrun = {
    gid = 593;
  };
  users.users.${user} = {
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "lrun" "docker" "libvirtd" "video" "audio" ];
    passwordFile = config.age.secrets."yakumo/hashed-password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn the.reason.sake@gmail.com"
    ];
  };
  services = {
    xserver.xkbOptions = "caps:escape";
    dbus.packages = [ pkgs.gcr ];
    getty.autologinUser = "${user}";
    gvfs.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
  console.useXkbConfig = true;

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
