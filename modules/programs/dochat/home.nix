# currently cannot run well...
{ config, lib, pkgs, ... }:
let
  dochat.sh = pkgs.stdenv.mkDerivation rec {
    name = "dochat.sh";
    src = pkgs.fetchgit {
      url = "https://github.com/huan/docker-wechat";
      rev = "b893a0842e75a3e00da57ad7cbd80462e60c0243";
      sha256 = "sha256-Nr5RZzMS1ynyCg3WB3PaKJoN7eyAMVodbozQ5JN5V4Y=";
    };
    # run "xhost local:root"
    # add "--net=host" to docker cmd
    # then run script
    buildPhase = ''
      sed -i 's/^\#\!\/usr\/bin\/env bash/\#\!\/bin\/bash/g' dochat.sh
    '';
    installPhase = ''
      mkdir -p $out/bin
      mv dochat.sh $out/bin
    '';
  };
in
{ 
  home.packages = with pkgs; [
    dochat.sh
    xorg.xhost
  ];
}
