{ config, pkgs, inputs, user, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports = [
    ./hardware-configuration.nix
  ] ++ [
    ../../modules/desktop/hyprland
    ../../modules/programs/openvpn
    ../../modules/programs/fonts
    ../../modules/programs/waybar
    ../../modules/programs/steam
    # ../../modules/programs/fish
    ../../modules/programs/zsh
    ../../modules/virtualisation
    # ../../modules/programs/rustdesk
    ../../modules/programs/clash
    # ../../modules/programs/syncthing
    ../../modules/programs/it-tools
    ../../modules/programs/games
    ../../modules/overlays/overlays.nix
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
  networking.extraHosts = ''
    10.222.252.1 cls-aivkqtcv.ccs.tencent-cloud.com
    10.233.252.1 cls-mhktarmn.ccs.tencent-cloud.com
    127.0.0.1 vault-file-proxy.ops
  '';
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
    extraGroups = [ "wheel" "lrun" "video" "audio" ];
    hashedPasswordFile = config.age.secrets."yakumo/hashed-password".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn the.reason.sake@gmail.com"
    ];
  };
  services = {
    xserver.xkb.options = "caps:escape";
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
    blueman.enable = true;
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

  # Nvidia card
  services.xserver.videoDrivers = [ "nvidia" ];
  services.tlp.enable = true;
  services.auto-cpufreq.enable = true;
  hardware = {
    nvidia = {
      open = false;
      nvidiaSettings = true;
      powerManagement.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "555.42.02";
        sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
        sha256_aarch64 = "sha256-ekx0s0LRxxTBoqOzpcBhEKIj/JnuRCSSHjtwng9qAc0=";
        openSha256 = "sha256-3/eI1VsBzuZ3Y6RZmt3Q5HrzI2saPTqUNs6zPh5zy6w=";
        settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
        persistencedSha256 = "sha256-3ae31/egyMKpqtGEqgtikWcwMwfcqMv2K4MVFa70Bqs=";
      };
      modesetting.enable = true;
      # prime = {
      #   offload.enable = true;
      # };
    };
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # extraPackages = with pkgs; [
      #   # nvidia-vaapi-driver
      #   vaapiVdpau
      #   # libvdpau-va-gl
      # ];
    };
  };
  environment.systemPackages = with pkgs; [
    nvidia-vaapi-driver
    libvdpau-va-gl
    nvidia-offload
    libva
    libva-utils
    glxinfo

    alsa-lib
    alsa-utils
    flac
    pulsemixer
    linux-firmware
  ];
}
