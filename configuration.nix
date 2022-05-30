{ config, pkgs, ...}:

{
  imports = [
    ./boot.nix
    ./version.nix
    ./users.nix
    ./time.nix
    ./environment.nix
    ./home.nix
    ./nix.nix
    ./agenix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
