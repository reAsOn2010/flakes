{
    description = "Yakumo's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = { 
            url= "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        agenix.url = "github:ryantm/agenix";
        homeage.url = "github:jordanisaacs/homeage";
        flake-utils.url = "github:numtide/flake-utils";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, agenix, homeage, hyprland, flake-utils, ... }@inputs:
    let
        inherit (self) outputs;
    in
    rec {
        nixConfig.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store/" ];
        nixosConfigurations = {
            pat = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs outputs; };
                modules = [
                  ./configuration.nix
                  ./hardware/pat.hardware-configuration.nix
                  home-manager.nixosModules.home-manager {
                    home-manager.extraSpecialArgs = { inherit inputs outputs; };
                  }
                  agenix.nixosModule
                  hyprland.nixosModules.default {
                    programs.hyprland.enable = true;
                    programs.hyprland.xwayland.enable = true;
                  }
                ];
            };
            xps13 = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    ./hardware/xps13.hardware-configuration.nix
                    home-manager.nixosModule
                    agenix.nixosModule
                ];
            };
            home = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    ./hardware/home.hardware-configuration.nix
                    home-manager.nixosModule
                    agenix.nixosModule
                ];
            };
        };
        homeConfigurations = {
            "yakumo@pat" = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                extraSpecialArgs = { inherit inputs outputs; };
                modules = [
                    ./home.nix
                ];
            };
        };

        devShells."x86_64-linux" = {
          ops = let 
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in pkgs.mkShell {
            buildInputs = with pkgs; [
              pkgs.gcc
              pkgs.glibc.out
              pkgs.glibc.static
              pkgs.libcxx
              pkgs.lld
              htop
              iotop
            ];
          };
          qt = let 
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in pkgs.mkShell {
            buildInputs = with pkgs; [
              pkgs.gcc
              pkgs.glibc.out
              pkgs.glibc.static
              pkgs.libcxx
              pkgs.lld
              pkgs.gdb
              pkgs.cmake
              pkgs.gnumake
              pkgs.qt5.full
              pkgs.qtcreator
              pkgs.protobuf
            ];
          };
        };
    };
}
