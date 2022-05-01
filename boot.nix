{ config, pkgs, ... }:

{
  boot.loader.system-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}