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
      rev = "cdab62c7973e16f4c069eb2006dd4fa92f102ef3";
      sha256 = "sha256-8SZqRvWoHPcuwa6BdOkdTKqzDp0f+NC1w824vD/lnqg=";
    };
    installPhase = ''
      mkdir -p $out/bin
      mv icon.png pomo.sh $out/bin

      mkdir -p $out/share
      mv *.mp3 $out/share
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
    mpv
  ];

  # [app-name=Pomodoro summary~="^End of a break period.*$"]
  # on-notify=exec ${pkgs.mpv}/bin/mpv ${pomo.sh}/share/work.mp3
  # default-timeout=10000
  # ignore-timeout=true
  # [app-name=Pomodoro summary~="^End of a work period.*$"]
  # on-notify=exec ${pkgs.mpv}/bin/mpv ${pomo.sh}/share/break.mp3
  # font=monospace 32
  # width=1366
  # height=768
  # text-alignment=center
  # anchor=center
  # ignore-timeout=true

  services.mako = {
    extraConfig = ''
      [app-name=Pomodoro]
      on-notify=exec ${pkgs.mpv}/bin/mpv ${pomo.sh}/share/break.mp3
    '';
  };
}
