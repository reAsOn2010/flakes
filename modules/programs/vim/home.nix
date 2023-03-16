{ config, pkgs, inputs, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
in
{
  # programs.nixneovim = {
  #   enable = true;
  #   extraConfigVim = ''
  #     syntax on
  #     set clipboard+=unnamedplus
  #     set number
  #   '';
  #   plugins = {
  #     nix = {
  #       enable = true;
  #     };
  #     lsp = {
  #       enable = true;
  #     };
  #     treesitter = {
  #       enable = true;
  #       indent = true;
  #     };
  #   };
  # };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.vim-nix
      {
        plugin = nix-colors-lib.vimThemeFromScheme { scheme = config.colorScheme; };
        config = "colorscheme nix-${config.colorScheme.slug}";
      }
    ];
    extraConfig = ''
      syntax on
      set clipboard+=unnamedplus
      set number
    '';
  };
}
