{ config, pkgs, inputs, ... }:
{
  home.packages = [
    pkgs.wpaperd
  ];
  home.file."${config.xdg.configHome}/wpaperd/config.toml".text = ''
    [default]
    path = "${config.xdg.configHome}/wallpapers/"
    duration = "30m"
    mode = "center"
  '';
}
