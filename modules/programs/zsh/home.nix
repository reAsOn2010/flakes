{ config, pkgs, inputs, user, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    shellAliases = {
      os-switch = "sudo nixos-rebuild switch --flake \"$HOME/nixos-config#\"";
      os-test = "sudo nixos-rebuild test --flake \"$HOME/nixos-config#\"";
      ops-shell = "nix develop \"$HOME/nixos-config#ops\"";
      qt-shell = "nix develop \"$HOME/nixos-config#qt\"";
      vault-dev = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.dev.env' >> .envrc ";
      vault-prod = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.prod.env' >> .envrc ";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "autojump"
        "direnv"
        "docker"
        "git"
        "kubectl"
        "tmux"
        "virtualenv"
      ];
      # theme = "powerlevel10k";
    };
    plugins = [
      {
        name = "zsh-autocomplete";
        src = pkgs.fetchFromGitHub {
          owner = "marlonrichert";
          repo = "zsh-autocomplete";
          rev = "23.05.24";
          sha256 = "sha256-/6V6IHwB5p0GT1u5SAiUa20LjFDSrMo731jFBq/bnpw=";
        };
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "p10k-config";
        src = ./conf;
        file = "p10k.zsh";
      }
    ];
    initExtra = ''
      export SHELL="${pkgs.zsh}/bin/zsh"
      bindkey "''${key[Up]}" up-line-or-search
    '';
    # interactiveShellInit = ''
    #   export SHELL="${pkgs.zsh}/bin/zsh"
    #   sh ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
    # '';
  };
}
