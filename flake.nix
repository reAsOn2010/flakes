{
    description = "Yakumo's NixOS configuration";

    inputs = {
        nixpkgs = { url = "github:nixos/nixpkgs/nixos-21.11"; };
        home-manager = { url= "github:nix-community/home-manager"; };
        agenix = { url = "github:ryantm/agenix"; };
    };

    outputs = inputs@{self, nixpkgs, home-manager, agenix }: {
        nixConfig.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store/" ];
        nixosConfigurations = {
            nixos = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    home-manager.nixosModule
                    agenix.nixosModule
                ];
            };
        };
    };
}
