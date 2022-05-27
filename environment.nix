{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    libinput.enable = true;
    libinput.mouse.accelProfile = "flat";
    libinput.mouse.accelSpeed = "-0.5";
  };

  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; 
  [
    libpinyin
    rime
  ];

  environment.systemPackages = with pkgs; [
    google-chrome
    gnome.networkmanager-openvpn
    gnomeExtensions.topicons-plus
    gnomeExtensions.appindicator
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
}
