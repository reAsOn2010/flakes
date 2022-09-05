{ config, pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-with-extensions;

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vscode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
      ms-vscode.cpptools
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "EditorConfig";
        publisher = "EditorConfig";
        version = "0.16.4";
        sha256 = "sha256-j+P2oprpH0rzqI0VKt0JbZG19EDE7e7+kAb3MGGCRDk=";
      }
      {
        name = "direnv";
        publisher = "mkhl";
        version = "0.6.1";
        sha256 = "sha256-5/Tqpn/7byl+z2ATflgKV1+rhdqj+XMEZNbGwDmGwLQ=";
      }
    ];
  };
  vault-dev-env = config.age.secrets."yakumo/vault.dev.env.age".path;
  vault-prod-env = config.age.secrets."yakumo/vault.prod.env.age".path;
in

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.yakumo = { config, pkgs, ...}: {
    home.stateVersion = "22.05";
    home.packages = with pkgs; 
    [
      adoptopenjdk-bin
      jetbrains.idea-community
      jetbrains.pycharm-community
      python310
      go
      clash
      vscode
      dbeaver
      albert
      copyq
      enpass
      kubectl
      mattermost-desktop
      silver-searcher
      # qtcreator
      synergy
      stretchly
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
      sessionVariables = {
        EDITOR = "vim";
      };
      shellAliases = {
        os-rebuild = "sudo nixos-rebuild switch --flake '/home/yakumo/nixos-config#'";
        agenix = "nix run github:ryantm/agenix --";
        ops-shell = "nix develop '/home/yakumo/nixos-config#ops'";
        qt-shell = "nix develop '/home/yakumo/nixos-config#qt'";
        vault-dev = "export $(cat ${vault-dev-env} | xargs)";
        vault-prod = "export $(cat ${vault-prod-env} | xargs)";
        ld-patch = "patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker)";
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
    # currently not supported
    # home.file.".kube/config".source = config.age.secrets."yakumo/kube-config.age".path;
  };
}
