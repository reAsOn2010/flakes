{ inputs, outputs, config, pkgs, lib, ... }: 
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.yakumo =
  {
    imports = [ ./home.nix ];
  };
}
