{ config, lib, pkgs, ... }:
let
  plum = pkgs.stdenv.mkDerivation rec {
    name = "plum";
    src = pkgs.fetchgit {
      url = "https://github.com/rime/plum.git";
      rev = "4c28f11f451facef809b380502874a48ba964ddb";
      sha256 = "sha256-4KrOYSNN2sjDhnMr4jZxF+0bPwRzj8oDsW0qSX23/dg=";
    };
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p $out/share $out/bin
      mv ./* $out/share
      ln -s $out/share/rime-install $out/bin/rime-install
    '';
  };
in
{
  home.packages = with pkgs; [
    plum
  ];
  home.file."${config.xdg.configHome}/fcitx5/conf/classicui.conf" = {
    source = ./classicui.conf;
  };
}
