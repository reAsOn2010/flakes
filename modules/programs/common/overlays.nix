{ config, lib, pkgs, ... }:
{
  nixpkgs.overlays = [
    # force obsidian use x11 to make input method work...
    (final: prev: {
      obsidian =
        prev.obsidian.overrideAttrs (oldAttrs: rec {
          installPhase = builtins.replaceStrings [ "--ozone-platform=wayland" ] [ "--ozone-platform=x11" ] oldAttrs.installPhase;
        });
    })
  ];
}
