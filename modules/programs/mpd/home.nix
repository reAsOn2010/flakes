{ config, pkgs, user, ... }:

{
  home.packages = with pkgs; [
    mpc-cli
    ymuse # gui client
    go-musicfox # netease cloud music
  ];
  services.mpd = {
    enable = true;
    musicDirectory = /home/${user}/Music;
    extraConfig = ''
      audio_output {
              type            "pipewire"
              name            "PipeWire Sound Server"
      }
    '';
  };
}
