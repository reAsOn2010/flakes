{ config, pkgs, inputs, unstable, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    # not avaliable in 22.11
    # defaultEditor = true;
    extraPackages = with pkgs; [
      gcc
      cargo
      ripgrep
      rnix-lsp
      shfmt
      kotlin-language-server
      stylua
      unstable.lua-language-server
      python310Packages.python-lsp-server
      nodePackages.vscode-json-languageserver
    ];
  };
  home.file."${config.xdg.configHome}/nvim/init.lua" = {
    source = ./init.lua;
  };
  home.file."${config.xdg.configHome}/nvim/lua" = {
    source = ./lua;
  };
}
