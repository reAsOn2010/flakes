sed -i 's#https://cache.nixos.org/#https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/#g' /etc/nix/nix.conf
# nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-21.11 nixos
nix-channel --update -v
nix-shell -p python310 --run "python3 build-env.py"