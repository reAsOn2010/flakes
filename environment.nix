{ pkgs, lib, ... }: let
  anydesk-autostart = (pkgs.makeAutostartItem { name = "AnyDesk"; package = pkgs.anydesk;  });
in
{
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # displayManager.autoLogin.enable = true;
    # displayManager.autoLogin.user = "yakumo";
    libinput.mouse.accelProfile = "flat";
    libinput.mouse.accelSpeed = "-0.5";
  };

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  services.openvpn.servers = {
    dev = { 
      config = '' config /tmp/openvpn/dev.ovpn ''; 
      autoStart = false;
      updateResolvConf = true;
    };
    prod = { 
      config = '' config /tmp/openvpn/prod.ovpn ''; 
      autoStart = false;
      updateResolvConf = true;
    };
  };

  environment.gnome.excludePackages = (with pkgs.gnome; [
    cheese
    epiphany
    tali
    iagno
    hitori
    atomix
  ]);

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; 
  [
    libpinyin
  ];

  environment.systemPackages = with pkgs; [
    nix-index
    patchelf
    exfat
    (callPackage "${builtins.fetchTarball {
      url = "https://github.com/ryantm/agenix/archive/main.tar.gz";
      sha256 = "14sszf5s85i4jd3lc8c167fbxvpj13da45wl1j7wpd20n0fic5c1";
    }}/pkgs/agenix.nix" {})
    gnome.networkmanager-openvpn
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.topicons-plus
    gnome3.adwaita-icon-theme
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    source-sans-pro
    wqy_microhei
    wqy_zenhei
  ];
  fonts.fontconfig.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.dnsname.enable = true;
    };
  };

  networking.extraHosts = ''
    10.222.252.1 cls-aivkqtcv.ccs.tencent-cloud.com
    10.233.252.1 cls-mhktarmn.ccs.tencent-cloud.com
  '';
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
    6568
    21118
    24800
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
    6568
    21118
    24800
  ];

  programs.steam = {
    enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];
}
