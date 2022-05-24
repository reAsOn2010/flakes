{ config, pkgs, ...}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./boot.nix
    ./version.nix
    ./user.nix
    ./display.nix
    ./time.nix
    ./softwares/vscode.nix
    ./softwares/simple.nix
    ./softwares/nix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
