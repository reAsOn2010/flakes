{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ];

  programs = {
    dconf.enable = true;
    hyprland.enable = true;
    hyprland.xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
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
    wayland-protocols
    glfw
    xwayland
    # qt6.qtwayland
    # qt5.qtwayland
    wev
    udiskie
    grim # screenshot
    slurp # screenshot

    # some packages for desktop?
    xdg-utils

    # some packages for graphic display?
    libGL
    libdrm
    libglvnd
    mesa
    mesa_glu
    mesa
    freetype
    dbus
    fontconfig
    libxcb
    libice
    libsm
    libxrender
    libxcb-image
    libxcb-wm
    xorg-server
    libpthread-stubs
    libx11
    libxext
    libxi
    xcb-proto
    libxcb-util
    libxcb-cursor
    libxcb-errors
    libxcb-keysyms
    libxcb-render-util

    networkmanagerapplet
  ];

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
    # wlr.enable = true;
  };
}
