{ system, self, inputs, user, ... }:
{
  pat = inputs.nixpkgs.lib.nixosSystem {
    # yakumo's pat-edu office computer config
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      inputs.agenix.nixosModules.default
      inputs.nur.nixosModules.nur
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
        home-manager =
          # allow use unstable pkgs in hm.
          let
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs user unstable; hostName = "pat"; };
            users.${user} = {
              # nixpkgs.config.allowUnfree = true;
              imports = [
                ./pat/home.nix
              ] ++ [
                inputs.hyprland.homeManagerModules.default
                inputs.nix-colors.homeManagerModule
                inputs.nixneovim.nixosModules.default
                inputs.nur.hmModules.nur
              ];
            };
          };
        nixpkgs = {
          overlays = (import ../overlays) ++ [
            inputs.nixneovim.overlays.default
            # self.overlays.default
          ];
        };
      }
    ];
  };
  home = inputs.nixpkgs.lib.nixosSystem {
    # yakumo's pat-edu office computer config
    inherit system;
    specialArgs = { inherit inputs user; };
    modules = [
      inputs.agenix.nixosModules.default
      ../agenix.nix
    ] ++ [
      ./home
    ] ++ [
      ./system.nix
      ./i18n.nix
    ] ++ [
      inputs.hyprland.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager =
          # allow use unstable pkgs in hm.
          let
            unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          in
          {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs user unstable; hostName = "home"; };
            users.${user} = {
              imports = [
                ./pat/home.nix
              ] ++ [
                inputs.hyprland.homeManagerModules.default
                inputs.nix-colors.homeManagerModule
                inputs.nixneovim.nixosModules.default
              ];
            };
          };
        nixpkgs = {
          overlays = (import ../overlays) ++ [
            inputs.nixneovim.overlays.default
            # self.overlays.default
          ];
        };
      }
    ];
  };
  xps13 = inputs.nixpkgs.lib.nixosSystem { };
}
