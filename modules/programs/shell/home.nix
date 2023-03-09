{ config, pkgs, user, ... }:
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
  };
  programs.autojump.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.git = {
    enable = true;
    userName = "${user}";
    userEmail = "the.reason.sake@gmail.com";
    signing = {
      signByDefault = true;
      key = "BCD10903364F5EFC";
    };
    extraConfig = {
      core.editor = "vim";
      safe.directory = "/home/${user}/nixos-config";
    };
  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    extraConfig = ''
      set -g mouse on
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
      };
    };
  };
  services.gpg-agent.enable = true;
  programs.gpg.enable = true;
}
