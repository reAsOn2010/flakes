#! /usr/bin/env bash

sed -i 's#https://cache.nixos.org/#https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/#g' /etc/nix/nix.conf
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-21.11 nixos
nix-channel --update -v

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
nixos-rebuild switch --flake github:reAsOn2010/nixos-config