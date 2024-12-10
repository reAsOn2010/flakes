{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      terminal.shell = {
        program = "${pkgs.zsh}/bin/zsh";
        args = [ "--login" ];
      };
      font.size = 14;
      # let hyprland set opacity
      # window.opacity = 0.9;
      general.import = [
        "${config.xdg.configHome}/alacritty/catppuccin-latte.toml"
      ];
    };
  };
  home.file."${config.xdg.configHome}/alacritty/catppuccin-latte.toml" = {
    source = ./catppuccin-latte.toml;
  };
}
