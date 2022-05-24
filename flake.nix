{
    description = "Yakumo's NixOS configuration"

    inputs = {
        nixpkgs = { url = "github:nixos/nixpkgs/nixos-21.11"}
    }

    outputs = inputs:
    {
        nixosConfigurations = {
            myNixOS = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                ]
                specialArgs = { inherit inputs; }
            }
        }
    }
}
