{ config, pkgs, inputs, user, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      os-switch = "sudo nixos-rebuild switch --flake \"$HOME/flakes#\"";
      os-test = "sudo nixos-rebuild test --flake \"$HOME/flakes#\"";
      ops-shell = "nix develop \"$HOME/flakes#ops\"";
      qt-shell = "nix develop \"$HOME/flakes#qt\"";
      vault-dev = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.dev.env' >> .envrc ";
      vault-prod = "[[ -f .envrc ]] || touch .envrc && " +
        "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
        "echo 'source ${config.xdg.configHome}/secrets/vault.prod.env' >> .envrc ";
      tg = "terragrunt";
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
        "opentofu"
      ];
      # theme = "powerlevel10k";
    };
    plugins = [
      # {
      #   name = "zsh-autocomplete";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "marlonrichert";
      #     repo = "zsh-autocomplete";
      #     rev = "23.05.24";
      #     sha256 = "sha256-/6V6IHwB5p0GT1u5SAiUa20LjFDSrMo731jFBq/bnpw=";
      #   };
      # }
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
      {
        name = "p10k-config-tofu-prompt";
        src = ./conf;
        file = "tofu-prompt.zsh";
      }
    ];
    initContent = ''
      export SHELL="${pkgs.zsh}/bin/zsh"
      bindkey "''${key[Up]}" up-line-or-search
      bindkey "''${key[Down]}" down-line-or-search
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C ${pkgs.terragrunt}/bin/terragrunt terragrunt
    '';
    # interactiveShellInit = ''
    #   export SHELL="${pkgs.zsh}/bin/zsh"
    #   sh ${nix-colors-lib.shellThemeFromScheme { scheme = config.colorScheme; }}
    # '';
  };
}
