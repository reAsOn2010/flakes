{
    description = "Yakumo's NixOS configuration";

    inputs = {
        nixpkgs = { url = "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/nixos-21.11"; };
        home-manager = { url= "https://github.com/nix-community/home-manager/archive/release-21.11.tar.gz"; };
    };

    outputs = inputs:
    {
        nixosConfigurations = {
            nixos = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                ];
                specialArgs = { inherit inputs; };
            };
        };
    };
}
