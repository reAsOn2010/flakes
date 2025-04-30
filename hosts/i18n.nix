{ config, pkgs, lib, inputs, user, ... }:
{
  i18n.supportedLocales = [
    "C.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8" 
    "zh_CN.UTF-8/UTF-8"
    "zh_CN.GB18030/GB18030"
  ];
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      fcitx5-material-color
      fcitx5-nord
      # fcitx5-pinyin-zhwiki
    ];
  };
}
 
