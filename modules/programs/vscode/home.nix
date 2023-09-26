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
      terminal.background = "#${config.colorScheme.colors.base00}";
      terminal.foreground = "#${config.colorScheme.colors.base05}";
      terminalCursor.background = "#${config.colorScheme.colors.base05}";
      terminalCursor.foreground = "#${config.colorScheme.colors.base05}";
      terminal.ansiBlack = "#${config.colorScheme.colors.base00}";
      terminal.ansiWhite = "#${config.colorScheme.colors.base05}";
      terminal.ansiBrightBlack = "#${config.colorScheme.colors.base03}";
      terminal.ansiBrightWhite = "#${config.colorScheme.colors.base07}";
      terminal.ansiRed = "#${config.colorScheme.colors.base08}";
      terminal.ansiYellow = "#${config.colorScheme.colors.base0A}";
      terminal.ansiGreen = "#${config.colorScheme.colors.base0B}";
      terminal.ansiCyan = "#${config.colorScheme.colors.base0C}";
      terminal.ansiBlue = "#${config.colorScheme.colors.base0D}";
      terminal.ansiMagenta = "#${config.colorScheme.colors.base0E}";
    };
  };
}
