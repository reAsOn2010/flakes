{ config, pkgs, inputs, user, ... }:
let 
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      os-switch = "sudo nixos-rebuild switch --flake '/home/yakumo/nixos-config#'";
      os-test = "sudo nixos-rebuild test --flake '/home/yakumo/nixos-config#'";
      ops-shell = "nix develop '/home/yakumo/nixos-config#ops'";
      qt-shell = "nix develop '/home/yakumo/nixos-config#qt'";
      vault-dev = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.dev.env' >> .envrc ";
      vault-prod = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.prod.env' >> .envrc ";
    };
    interactiveShellInit = ''
      sh ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
    '';
    # plugins = [
    #   {
    #     name = "bobthefish";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "oh-my-fish";
    #       repo = "theme-bobthefish";
    #       rev = "2dcfcab653ae69ae95ab57217fe64c97ae05d8de";
    #       sha256 = "sha256-jBbm0wTNZ7jSoGFxRkTz96QHpc5ViAw9RGsRBkCQEIU=";
    #     };
    #   }
    # ];
  };
}
