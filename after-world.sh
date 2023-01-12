# import gpg
read -p "Please provide gpg 'secretkey.asc' path: " path
gpg --import $path

mkdir -p ~/Document/pintia
git clone git@github.com:pintia/inside-identity.git
git clone git@github.com:pintia/gist.git

