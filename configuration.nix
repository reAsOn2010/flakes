{ config, pkgs, ...}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./version.nix
    ./user.nix
    ./display.nix
    ./time.nix
    ./softwares/vscode.nix
    ./softwares/idea.nix
    ./softwares/java.nix
    ./softwares/nix.nix
  ];
}