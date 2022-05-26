#! /usr/bin/env bash

mkdir -p /etc/nixos/secrets/users/root
tr -cd '[:alnum:]' < /dev/urandom | head -c16 | mkpasswd -m sha-512 -s > /etc/nixos/secrets/users/root/hashed-password

while true; do
  read -s -p "Password: " password
  echo
  read -s -p "Password (again): " password2
  echo
  [ "$password" = "$password2" ] && break
  echo "Please try again"
done

mkdir -p /etc/nixos/secrets/users/yakumo
echo "$password" | mkpasswd -m sha-512 -s > /etc/nixos/secrets/users/yakumo/hashed-password

nix-shell -p git --run "git clone https://github.com/reAsOn2010/nixos-config.git /tmp/nixos-config"
nix-shell -p git --run "nixos-rebuild switch --flake \"/tmp/nixos-config#.\""
