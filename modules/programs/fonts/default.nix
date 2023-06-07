{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    fonts = with pkgs; [
      # dejavu_fonts
      # source-sans-pro
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
      # source-han-mono
      # source-han-sans
      # source-han-serif
      font-awesome
    ];
    fontDir.enable = true;
    fontconfig.enable = true;
  };
}
