# import gpg
read -p "Please provide gpg 'secretkey.asc' path: " path
gpg --import $path

# import openvpn config
sudo nmcli connection import type openvpn file /run/agenix/yakumo/dev.ovpn
sudo nmcli connection import type openvpn file /run/agenix/yakumo/prod.ovpn

mkdir -p ~/Documents/pintia
pushd ~/Documents/pintia
git clone git@github.com:pintia/inside-identity.git
git clone git@github.com:pintia/gist.git
popd

