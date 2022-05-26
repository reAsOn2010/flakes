{ config, pkgs, ...}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./boot.nix
    ./version.nix
    ./users.nix
    ./display.nix
    ./time.nix
    ./environment.nix
    <home-manager/nixos>
    ./home.nix
    ./nix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
