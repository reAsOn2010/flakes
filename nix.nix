{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
