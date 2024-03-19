{ config, pkgs, inputs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    joycond
    opentabletdriver
  ];
}
