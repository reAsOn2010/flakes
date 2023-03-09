{ config, lib, pkgs, hostName, ... }:
{
  imports = [
    (import ../../environment/variables.nix)
    (import ../../programs/mako/home.nix)
    (import ../../programs/cliphist/home.nix)
    (import ../../programs/rofi/home.nix)
    (import ../../programs/swayidle/home.nix)
    (import ../../programs/swaylock/home.nix)
    (import ../../programs/waybar/home.nix)
    (import ../../programs/wpaperd/home.nix)
  ];
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           exec  Hyprland
        fi
      '';
    };
    # fish = {
    #   loginShellInit = ''
    #      set TTY1 (tty)
    #      [ "$TTY1" = "/dev/tty1" ] && exec dbus-run-session Hyprland
    #   '';
    # };
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    nvidiaPatches = false;
    extraConfig = builtins.readFile (./. + "/${hostName}.conf") + builtins.readFile ./hyprland.conf;
  };
}
