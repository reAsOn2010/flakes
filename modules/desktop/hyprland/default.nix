{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ];

  programs = {
    dconf.enable = true;
    light.enable = true;
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libnotify
    # inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    # inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    # libnotify
    # wl-clipboard
    # wlr-randr
    # wayland
    # wayland-scanner
    # wayland-utils
    egl-wayland
    xorg.xeyes
    wayland-protocols
    glfw-wayland
    xwayland
    qt6.qtwayland
    qt5.qtwayland
    wev
    udiskie
    # grim
  ];

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
