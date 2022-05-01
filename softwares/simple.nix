{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    adoptopenjdk-bin
    jetbrains.idea-community
  ];
}