sed -i 's/^substituters/#&/g' /etc/nix/nix.conf
echo 'substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/' >> /etc/nix/nix.conf
# nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixpkgs-unstable nixpkgs
nix-channel --add https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-21.11 nixos
nix-channel --update -v
nix-shell -p python310 --run "python3 build-env.py"