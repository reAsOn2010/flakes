{ inputs, outputs, pkgs, config, lib, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  # wayland.windowManager.sway = {
  #   enable = true;
  #   config = rec {
  #     modifier = "Mod4";
  #     terminal = "alacritty";
  #     startup = [];
  #     menu = "${pkgs.rofi-wayland}/bin/rofi -show";
  #     bars = [ {
  #       mode = "dock";
  #       hiddenState = "hide";
  #       position = "top";
  #       workspaceButtons = true;
  #       workspaceNumbers = true;
  #       statusCommand = "${pkgs.i3status}/bin/i3status";
  #       fonts = {
  #         names = [ "source-sans-pro" "monospace" ];
  #         size = 12.0;
  #       };
  #       trayOutput = "primary";
  #       colors = {
  #         background = "#000000";
  #         statusline = "#ffffff";
  #         separator = "#666666";
  #         focusedWorkspace = {
  #           border = "#4c7899";
  #           background = "#285577";
  #           text = "#ffffff";
  #         };
  #         activeWorkspace = {
  #           border = "#333333";
  #           background = "#5f676a";
  #           text = "#ffffff";
  #         };
  #         inactiveWorkspace = {
  #           border = "#333333";
  #           background = "#222222";
  #           text = "#888888";
  #         };
  #         urgentWorkspace = {
  #           border = "#2f343a";
  #           background = "#900000";
  #           text = "#ffffff";
  #         };
  #         bindingMode = {
  #           border = "#2f343a";
  #           background = "#900000";
  #           text = "#ffffff";
  #         };
  #       };
  #     } ];
  #   };
  # };

  home.packages = with pkgs;
  [
    mako            # notification daemon
    waybar          # status bar
    rofi-wayland    # application launcher
    grim            # screenshot
    cliphist        # clipboard manager
    wl-clipboard
  ];
  home.file."${config.xdg.configHome}/waybar" = {
    source = ./waybar;
    recursive = true;
  };
  home.file."${config.xdg.configHome}/mako" = {
    source = ./mako;
    recursive = true;
  };
}
