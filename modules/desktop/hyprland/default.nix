{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ];

  programs = {
    dconf.enable = true;
    light.enable = true;
    hyprland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    libnotify
    # inputs.hypr-contrib.packages.${pkgs.system}.grimblast
    # inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    # libnotify
    # wpaperd
    # wl-clipboard
    # wlr-randr
    # wayland
    # wayland-scanner
    # wayland-utils
    # egl-wayland
    # xorg.xeyes
    # wayland-protocols
    # glfw-wayland
    # xwayland
    # qt6.qtwayland
    # libsForQt5.qt5.qtwayland
    # wev
    # grim
    # swaylock-effects
  ];

  # systemd.user.services.swww = {
  #   description = "Efficient animated wallpaper daemon for wayland";
  #   wantedBy = [ "graphical-session.target" ];
  #   partOf = [ "graphical-session.target" ];
  #   before = [ "default_wall.service" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = ''
  #       ${pkgs.swww}/bin/swww-daemon
  #     '';
  #     ExecStop = "${pkgs.swww}/bin/swww kill";
  #     Restart = "on-failure";
  #   };
  # };

  security.pam.services.swaylock = { };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
