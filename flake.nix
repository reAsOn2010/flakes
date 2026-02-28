{
  description = "Yakumo's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    # hypr-contrib.url = "github:hyprwm/contrib";
    # hyprpicker.url = "github:hyprwm/hyprpicker";
    agenix.url = "github:ryantm/agenix";
    homeage.url = "github:jordanisaacs/homeage";
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";
    nixneovim.url = "github:nixneovim/nixneovim";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    update-systemd-resolved.url = "github:jonathanio/update-systemd-resolved";
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
