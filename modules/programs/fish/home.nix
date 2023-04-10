{ config, pkgs, inputs, user, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    grc
  ];
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
      export SHELL="${pkgs.fish}/bin/fish"
      sh ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
    '';
    plugins = [
      { name = "grc"; src = pkgs.fishPlugins.grc.src; }
      { name = "tide"; src = pkgs.fishPlugins.tide.src; }
    ];
  };
}
