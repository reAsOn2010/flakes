{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixFlakes;
    settings.substituters = [ 
      "https://mirrors.ustc.edu.cn/nix-channels/store" 
      "https://hyprland.cachix.org"
    ];
    settings.trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
