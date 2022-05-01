{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    adoptopenjdk-bin
    jetbrains.idea-community
    python310
    go
    clash
    google-chrome
  ];
}