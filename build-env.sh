#! /usr/bin/env bash

# prepare ssh keys
mkdir -p /root/.ssh
mkdir -p /home/yakumo/.ssh
read -p "Please input key path: " path
nix-shell -p unzip --run "unzip $path -d /tmp"
cp /tmp/id_ed25519 /root/.ssh
cp /tmp/id_ed25519 /tmp/id_ed25519.pub /home/yakumo/.ssh
chown 1000 -R /home/yakumo/.ssh
chmod 400 /root/.ssh/id_ed25519
chmod 400 /home/yakumo/.ssh/id_ed25519

# run
nix-shell -p git --run "git clone https://github.com/reAsOn2010/flakes.git /tmp/flakes"
nix-shell -p git --run "nixos-rebuild switch --flake \"/tmp/flakes#\""
