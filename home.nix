{ pkgs, ... }:

let
  inherit (pkgs) vscode-extensions vscode-with-extensions;

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
    ];
  };
in

{
  home-manager.users.yakumo = { pkgs, ...}: {
    home.packages = with pkgs; 
    [
      adoptopenjdk-bin
      jetbrains.idea-community
      python310
      go
      clash
      vscode
      enpass
      dbeaver
      alacritty
      albert
      anydesk
      copyq
      vim
    ];
    programs.git = {
      enable = true;
      userName = "yakumo";
      userEmail = "the.reason.sake@gmail.com";
    };
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}