{ config, pkgs, ... }:
{
  programs.neovim = {
	  enable = true;
	  viAlias = true;
	  vimAlias = true;
	  vimdiffAlias = true;
		extraConfig = ''
			syntax on
			set clipboard+=unnamedplus
			set number
		'';
  };
}
