{ config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      ms-vscode.cpptools
      mkhl.direnv
      editorconfig.editorconfig
    ];
    userSettings = {
      terminal.integrated.shell.linux = "${pkgs.zsh}/bin/zsh";
      editor.fontSize = 18;
      terminal.background = "#${config.colorScheme.palette.base00}";
      terminal.foreground = "#${config.colorScheme.palette.base05}";
      terminalCursor.background = "#${config.colorScheme.palette.base05}";
      terminalCursor.foreground = "#${config.colorScheme.palette.base05}";
      terminal.ansiBlack = "#${config.colorScheme.palette.base00}";
      terminal.ansiWhite = "#${config.colorScheme.palette.base05}";
      terminal.ansiBrightBlack = "#${config.colorScheme.palette.base03}";
      terminal.ansiBrightWhite = "#${config.colorScheme.palette.base07}";
      terminal.ansiRed = "#${config.colorScheme.palette.base08}";
      terminal.ansiYellow = "#${config.colorScheme.palette.base0A}";
      terminal.ansiGreen = "#${config.colorScheme.palette.base0B}";
      terminal.ansiCyan = "#${config.colorScheme.palette.base0C}";
      terminal.ansiBlue = "#${config.colorScheme.palette.base0D}";
      terminal.ansiMagenta = "#${config.colorScheme.palette.base0E}";
    };
  };
}
