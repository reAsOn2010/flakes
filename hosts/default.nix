{ system, self, inputs, nixpkgs, user, ... }:

let
  pkgs = import nixpkgs
    {
      inherit system;
      config.allowUnfree = true;
    };
  lib = nixpkgs.lib;
in
{
  pat = lib.nixosSystem {
    # my Office config
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      inputs.agenix.nixosModule
      ../agenix.nix
    ] ++ [
      ./pat
    ] ++ [
      ./system.nix
      ./i18n.nix
    ] ++ [
      inputs.hyprland.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs user; hostName = "pat"; };
          users.${user} = {
            imports = [
              (import ./pat/home.nix)
            ] ++ [
              inputs.hyprland.homeManagerModules.default
            ];
          };
        };
        nixpkgs = {
          overlays = (import ../overlays) ++ [
            # self.overlays.default
          ];
        };
      }
    ];
  };
  xps13 = lib.nixosSystem { };
}
