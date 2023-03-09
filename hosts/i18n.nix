{ config, pkgs, lib, inputs, user, ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
      # fcitx5-pinyin-zhwiki
    ];
  };
}
 