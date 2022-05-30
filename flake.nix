{
    description = "Yakumo's NixOS configuration";

    inputs = {
        nixpkgs = { url = "github:nixos/nixpkgs/nixos-21.11"; };
        home-manager = { url= "github:nix-community/home-manager"; };
        agenix = { url = "github:ryantm/agenix"; };
        flake-utils = { url = "github:numtide/flake-utils"; };
    };

    outputs = inputs@{self, nixpkgs, home-manager, agenix, flake-utils }: {
        nixConfig.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/" ];
        nixosConfigurations = {
            pat = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    ./hardware/pat.hardware-configuration.nix
                    home-manager.nixosModule
                    agenix.nixosModule
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
        devShells."x86_64-linux" = {
          ops = let 
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
          in pkgs.mkShell {
            buildInputs = with pkgs; [
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
            ];
          };
        };
    };
}
