{ config, lib, pkgs, ... }:
let
  vpnctl = pkgs.writeShellScriptBin "vpnctl" (builtins.readFile ./vpnctl);
  lock = pkgs.writeShellScriptBin "lock" ''exec swaylock'';
  dlwallpaper = pkgs.writeShellScriptBin "dlwallpaper" (builtins.readFile ./dlwallpaper);
  ld-patch = pkgs.writeShellScriptBin "ld-patch" (builtins.readFile ./ld-patch);
  pomo.sh = pkgs.stdenv.mkDerivation rec {
    name = "pomo.sh";
    src = pkgs.fetchgit {
      url = "https://github.com/reAsOn2010/pomo";
      rev = "636b5333618fd5b4de600c344c3b769be844c38d";
      sha256 = "sha256-gBWaf3uy52d2SYAqVSL05C8qfn5gQQSIGqw1xhCXz7I=";
    };
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
    dochat.sh
  ];
}
