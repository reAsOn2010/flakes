{
  description = "Yakumo's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    agenix.url = "github:ryantm/agenix";
    homeage.url = "github:jordanisaacs/homeage";
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";
    nixneovim.url = "github:nixneovim/nixneovim";
  };

  outputs = { self, ... }@inputs:
    let
      user = "yakumo";
    in
    {
      # overlays.default = selfPkgs.overlay;
      nixosConfigurations = (
        # NixOS configurations
        import ./hosts {
          system = "x86_64-linux";
          inherit self inputs user;
        }
      );
    };
}
