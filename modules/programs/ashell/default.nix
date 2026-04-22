{ config, lib, pkgs, inputs, ... }:
{
  environment.systemPackages = [
    inputs.ashell.packages.${pkgs.system}.default
  ];
}
