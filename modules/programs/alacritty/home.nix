{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [ "--login" ];
      };
      # let hyprland do opcatity
      # window.opacity = 0.9;
      font.size = 14;
    };
  };
}
