{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    binaryCaches = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}