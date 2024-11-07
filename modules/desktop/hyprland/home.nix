{ config, lib, pkgs, inputs, hostName, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
  monitors = import ./monitors.nix { inherit pkgs hostName; };
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
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.packages = with pkgs; [
    pantheon.pantheon-agent-polkit
    # libsForQt5.polkit-kde-agent
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        variant = "latte";
      };
      name = "catppuccin";
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors;
      name = "latteBlue";
    };
    # Original config
    # theme = {
    #   package = nix-colors-lib.gtkThemeFromScheme {
    #     scheme = config.colorScheme;
    #   };
    #   name = config.colorScheme.slug;
    # };
    # iconTheme = {
    #   package = pkgs.numix-icon-theme;
    #   name = "numix";
    # };
    # cursorTheme = {
    #   package = pkgs.vanilla-dmz;
    #   name = "Vanilla-DMZ";
    # };
    gtk2.extraConfig = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    extraConfig = builtins.readFile monitors.hypr-monitor-conf + builtins.readFile ./hyprland.conf + ''
      # exec-once = ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1
      exec-once = ${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit
    '';
  };
}
