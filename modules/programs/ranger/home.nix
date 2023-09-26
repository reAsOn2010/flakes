{ config, pkgs, ... }:
let
  # override default entrypoint
  # Type=Application
  # Name=ranger
  # Comment=Launches the ranger file manager
  # Icon=utilities-terminal
  # Terminal=true
  # Exec=ranger
  # Categories=ConsoleOnly;System;FileTools;FileManager
  # MimeType=inode/directory;
  # Keywords=File;Manager;Browser;Explorer;Launcher;Vi;Vim;Python
  rangerApp = pkgs.makeDesktopItem {
    name = "ranger.app";
    desktopName = "Ranger.app";
    comment = "Launches the ranger file manager";
    icon = "utilities-terminal";
    exec = "${pkgs.alacritty}/bin/alacritty --title Ranger.app --class Ranger.app -e ${pkgs.ranger}/bin/ranger";
    terminal = false;
    categories = [ "ConsoleOnly" "System" "FileTools" "FileManager" ];
    mimeTypes = [ "inode/directory" ];
    keywords = [ "File" "Manager" "Browser" "Explorer" "Launcher" "Vi" "Vim" "Python" ];
  };
in
{
  home.packages = with pkgs; [
    ranger
    rangerApp
    python310Packages.chardet
    python310Packages.python-bidi
    w3m
    ffmpeg
    highlight
    mediainfo
    trash-cli
  ];
}
