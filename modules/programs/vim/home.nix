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
      python310Packages.python-lsp-server
      python310Packages.rope
      python310Packages.pyflakes
      python310Packages.mccabe
      python310Packages.pycodestyle
      python310Packages.autopep8
      nodePackages.vscode-json-languageserver
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
