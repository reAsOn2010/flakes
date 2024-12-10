{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    twemoji-color-font
  ];
  fonts = {
    packages = with pkgs; [
      # dejavu_fonts
      # source-sans-pro
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerdfonts
      twemoji-color-font
      # source-han-mono
      # source-han-sans
      # source-han-serif
      font-awesome
      # wqy_zenhei # steam uses this font
    ];
    fontDir.enable = true;
    fontconfig.enable = true;
  };
}
