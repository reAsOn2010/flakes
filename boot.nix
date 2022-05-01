{ config, pkgs, ... }:

{
  boot.loader = {
    system-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}