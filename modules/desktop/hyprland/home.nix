{ config, lib, pkgs, inputs, hostName, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  imports = [
    ../../environment/variables.nix
    ../../programs/mako/home.nix
    ../../programs/cliphist/home.nix
    ../../programs/rofi/home.nix
    ../../programs/swayidle/home.nix
    ../../programs/swaylock/home.nix
    ../../programs/waybar/home.nix
    ../../programs/wpaperd/home.nix
    ../../programs/homeage/home.nix
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
  gtk = {
    enable = true;
    theme = {
      package = nix-colors-lib.gtkThemeFromScheme {
        scheme = config.colorScheme;
      };
      name = config.colorScheme.slug;
    };
    iconTheme = {
      package = pkgs.numix-icon-theme;
      name = "numix";
    };
    cursorTheme = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemdIntegration = true;
    extraConfig = builtins.readFile (./. + "/${hostName}.conf") + builtins.readFile ./hyprland.conf + ''
      exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
    '';
  };
}
