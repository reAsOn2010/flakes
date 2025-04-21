{ config, pkgs, lib, inputs, ... }:
let 
  system = "x86_64-linux";
  vscodeExts = inputs.nix-vscode-extensions.extensions.${system};
in {
  home.packages = with pkgs; [
    editorconfig-core-c
  ];
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.override {
      commandLineArgs = "--enable-wayland-ime";
    };
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      ms-vscode.cpptools
      mkhl.direnv
      editorconfig.editorconfig
    ] ++ (with vscodeExts.vscode-marketplace; [
      # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
      # giscafer.leek-fund
      hashicorp.terraform
      hashicorp.hcl
    ]);
    userSettings = {
      window.zoomLevel = 0.5;
      editor.fontSize = 16;
      terminal.integrated.fontFamily = "MesloLGS Nerd Font";
      terminal.integrated.fontSize = 16;
      terraform.languageServer = {
        command= "tofu";
        args= ["serve"];
      };
      terminal.integrated.shell.linux = "${pkgs.zsh}/bin/zsh";
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
