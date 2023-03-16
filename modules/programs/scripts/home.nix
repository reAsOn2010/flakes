{ config, lib, pkgs, ... }:
let
  vpnctl = pkgs.writeShellScriptBin "vpnctl" (builtins.readFile ./vpnctl);
  lock = pkgs.writeShellScriptBin "lock" ''exec swaylock'';
  dlwallpaper = pkgs.writeShellScriptBin "dlwallpaper" (builtins.readFile ./dlwallpaper);
  ld-patch = pkgs.writeShellScriptBin "ld-patch" (builtins.readFile ./ld-patch);
  pomo.sh = pkgs.stdenv.mkDerivation rec {
    name = "pomo.sh";
    src = pkgs.fetchgit {
      url = "https://github.com/jsspencer/pomo";
      rev = "47e57fe2c75677bd7a1491f93510e830a8008cac";
      sha256 = "sha256-eGLjvfKeTgSuC7sCk7qN5K73tr5vbJHuD0v7cIg5ZpA=";
    };
    patches = [ ./pomo.diff ];
    installPhase = ''
      mkdir -p $out/bin
      mv pomo.sh $out/bin
    '';
  };
in
{
  home.packages = with pkgs; [
    vpnctl
    lock
    dlwallpaper
    ld-patch
    pomo.sh
  ];
}
