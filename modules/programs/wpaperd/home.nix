{ config, pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  home.packages = [ unstable.wpaperd ];
  home.file."${config.xdg.configHome}/wpaperd/output.conf".text = ''
    [default]
    path = "${config.xdg.configHome}/wallpapers/"
    duration = "30m"
  '';
}
