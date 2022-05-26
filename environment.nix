{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;
  i18n.inputMethod.enabled = "ibus";
  i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; 
  [
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
    ubuntu_font_family
  ];
}
