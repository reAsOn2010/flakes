#! /usr/bin/env bash

nix-shell -p git --run "git clone https://github.com/reAsOn2010/nixos-config.git /tmp/nixos-config"
nix-shell -p git --run "nixos-rebuild switch --flake \"/tmp/nixos-config#.\""
