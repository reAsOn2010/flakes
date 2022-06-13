{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "yakumo";
    libinput.mouse.accelProfile = "flat";
    libinput.mouse.accelSpeed = "-0.5";
  };

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
  ];

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
    exfat
    google-chrome
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
    };
  };

  networking.extraHosts = ''
    10.222.252.1 cls-aivkqtcv.ccs.tencent-cloud.com
    10.233.252.1 cls-mhktarmn.ccs.tencent-cloud.com
  '';

  programs.steam = {
    enable = true;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];
}
