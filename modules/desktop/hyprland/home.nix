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
  };
  home.packages = with pkgs; [
    libsForQt5.polkit-kde-agent
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemdIntegration = true;
    nvidiaPatches = false;
    extraConfig = builtins.readFile (./. + "/${hostName}.conf") + builtins.readFile ./hyprland.conf + ''
      exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
    '';
  };
}
