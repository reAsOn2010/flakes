{ config, pkgs, inputs, unstable, ... }:
let
  nix-colors-lib = inputs.nix-colors.lib-contrib { inherit pkgs; };
  kubernetes-json-schema = pkgs.stdenv.mkDerivation rec {
    name = "kubernetes-json-schema";
    installPhase = ''
      ${pkgs.curl}/bin/curl -Lo kubernetes-json-schema.zip  https://github.com/yannh/kubernetes-json-schema/archive/56bf290929798cb844d8d5c0e9bc28d1da330ba8.zip
      
      mkdir $out
    '';
  };
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
      unstable.nodePackages.vscode-json-languageserver
      unstable.nodePackages.yaml-language-server
      terraform-ls
      rust-analyzer
      gopls
    ];
  };
  home.file."${config.xdg.configHome}/nvim/init.lua" = {
    source = ./init.lua;
  };
  home.file."${config.xdg.configHome}/nvim/lua" = {
    source = ./lua;
  };
  # It is too big!!!
  # home.file."${config.xdg.configHome}/json-schemas/kubernetes" = {
  #   source = pkgs.fetchzip {
  #     url = "https://github.com/yannh/kubernetes-json-schema/archive/56bf290929798cb844d8d5c0e9bc28d1da330ba8.zip";
  #     hash = "";
  #   };
  # };
}
