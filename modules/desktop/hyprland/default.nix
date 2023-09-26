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
    wayland-protocols
    glfw-wayland
    xwayland
    qt6.qtwayland
    qt5.qtwayland
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
    mesa_drivers
    freetype
    dbus
    fontconfig
    xorg.libxcb
    xorg.libICE
    xorg.libSM
    xorg.libXrender
    xorg.xcbutilimage
    xorg.xcbutilwm
    xorg.xorgserver
    xorg.libpthreadstubs
    xorg.libX11
    xorg.libXext
    xorg.libXi
    xorg.xcbproto
    xorg.xcbutil
    xorg.xcbutilcursor
    xorg.xcbutilerrors
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
    xorg.xorgproto
  ];

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    # wlr.enable = true;
  };
}
