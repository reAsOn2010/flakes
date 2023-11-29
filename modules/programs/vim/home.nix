{ config, pkgs, inputs, unstable, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  home.packages = [
    pkgs.luajitPackages.jsregexp
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      gcc
      cargo
      ripgrep
      rnix-lsp
      shfmt
      kotlin-language-server
      stylua
      lua-language-server
      unstable.nodePackages.pyright
      unstable.ruff-lsp
      unstable.nodePackages.prettier
      python311Packages.autopep8
      nodePackages.vscode-json-languageserver
      unstable.nodePackages.yaml-language-server
      rust-analyzer
    ];
  };
  home.file."${config.xdg.configHome}/nvim/init.lua" = {
    source = ./init.lua;
  };
  home.file."${config.xdg.configHome}/nvim/lua" = {
    source = ./lua;
  };
}
