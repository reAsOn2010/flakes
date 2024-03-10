{ config, pkgs, ... }:
{
  programs.firefox.enable = true;
  programs.qutebrowser = {
    enable = true;
    searchEngines.DEFAULT = "https://www.google.com/search?hl=en&q={}";
    settings = {
      colors.webpage.darkmode.enabled = true;
      url.start_pages = [
        "https://www.google.com"
      ];
    };
  };
  # home.packages = with pkgs; [
  #   microsoft-edge
  # ];
}

