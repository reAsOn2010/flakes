{ pkgs, ... }:

let
  inherit (pkgs) vscode-extensions vscode-with-extensions;

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
    ];
  };
in

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.yakumo = { pkgs, ...}: {
    home.packages = with pkgs; 
    [
      adoptopenjdk-bin
      jetbrains.idea-community
      python310
      go
      clash
      vscode
      dbeaver
      albert
      anydesk
      copyq
      enpass
      qtcreator
    ];
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [ "--login" ];
        };
        font.size = 14;
      };
    };
    programs.vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ dracula-vim ];
      extraConfig = ''
        syntax on
        set clipboard=unnamedplus

        if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
          let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
          let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        endif

        set termguicolors
        colorscheme dracula
      '';
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        osrebuild = "sudo nixos-rebuild switch --flake '/home/yakumo/nixos-config#'";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "dotenv" "kubectl" "history" "docker" ];
        theme = "robbyrussell";
      };
    };
    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    programs.git = {
      enable = true;
      userName = "yakumo";
      userEmail = "the.reason.sake@gmail.com";
      signing = {
        signByDefault = true;
        key = "BCD10903364F5EFC";
      };
      extraConfig = {
        core.editor = "vim";
        safe.directory = "/home/yakumo/nixos-config";
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
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Ctrl>space";
        command = "albert toggle";
        name = "albert-toggle";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>t";
        command = "alacritty";
        name = "alacritty";
      };
    };
    services.gpg-agent.enable = true;
    programs.gpg.enable = true;
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    xdg.enable = true;
    xdg.configFile."albert/albert.conf".text = ''
      [General]
      hotkey=Ctrl+Space
      showTray=true
      terminal=alacritty -e

      [org.albert.extension.applications]
      enabled=true

      [org.albert.extension.calculator]
      enabled=true

      [org.albert.frontend.widgetboxmodel]
      alwaysOnTop=true
      clearOnHide=false
      displayIcons=true
      displayScrollbar=false
      displayShadow=true
      hideOnClose=false
      hideOnFocusLoss=true
      itemCount=5
      showCentered=true
      theme=Bright
    '';
  };
}
