{ config, pkgs, user, ... }:
{
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
      safe.directory = "/home/${user}/flakes";
    };
  };
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      set -g mouse on
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
  programs.zellij = {
    enable = true;
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
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 7200;
    defaultCacheTtlSsh = 7200;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    pinentry = {
      package = pkgs.pinentry-qt;
    };
  };
  programs.gpg.enable = true;
}
