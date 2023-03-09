{ config, pkgs, ... }:
{
  imports = [
    (import ../alacritty/home.nix)
    (import ../shell/home.nix)
    (import ../firefox/home.nix)
    (import ../neovim/home.nix)
    (import ../vscode/home.nix)
    (import ../scripts/home.nix)
  ];

    home.packages = with pkgs; 
    [
      adoptopenjdk-bin
      firefox
      rustdesk
      jetbrains.idea-community
      jetbrains.pycharm-community
      python310
      go
      nixpkgs-fmt
      dbeaver
      enpass
      kubectl
      silver-searcher
      mongodb-compass
      synergy
    ];

}
