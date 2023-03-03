{ inputs, outputs, config, pkgs, lib, ... }:

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
in {
    imports = [ 
      inputs.homeage.homeManagerModules.homeage 
      ./wayland
    ];
    homeage = {
        identityPaths = [ "~/.ssh/id_ed25519" ];
        installationType = "systemd";
        file."kube-config" = {
          source = ./secrets/yakumo/kube-config.age;
          copies = [ "/home/yakumo/.kube/config" ];
          mode = "0600";
        };
        file."vault.dev.env" = {
          source = ./secrets/yakumo/vault.dev.env.age;
          symlinks = [ "${config.xdg.configHome}/secrets/vault.dev.env" ];
        };
        file."vault.prod.env" = {
          source = ./secrets/yakumo/vault.prod.env.age;
          symlinks = [ "${config.xdg.configHome}/secrets/vault.prod.env" ];
        };
        file."docker.config.json" = {
          source = ./secrets/yakumo/docker.config.json.age;
          symlinks = [ "/home/yakumo/.docker/config.json" ];
        };
    };
    i18n.inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-chinese-addons
      ];
    };
    home.stateVersion = "22.11";
    home.packages = with pkgs; 
    [
      adoptopenjdk-bin
      google-chrome
      firefox
      rustdesk
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
      mongodb-compass
      synergy
    ];
    programs.alacritty = {
      enable = true;
      settings = {
        env.TERM = "xterm-256color";
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
          args = [ "--login" ];
        };
        window.opacity = 0.9;
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
        set number
        colorscheme dracula
        hi NonText ctermbg=none
        hi Normal guibg=NONE ctermbg=NONE
      '';
    };
    home.sessionVariables = {
      EDITOR = "vim";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "fcitx";
    };
    home.sessionPath = [
      "${config.xdg.configHome}/scripts"
    ];
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = {
        os-rebuild = "sudo nixos-rebuild switch --flake '/home/yakumo/nixos-config#'";
        ops-shell = "nix develop '/home/yakumo/nixos-config#ops'";
        qt-shell = "nix develop '/home/yakumo/nixos-config#qt'";
        vault-dev = "[[ -f .envrc ]] || touch .envrc && " + 
          "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
          "echo 'source ${config.xdg.configHome}/secrets/vault.dev.env' >> .envrc ";
        vault-prod = "[[ -f .envrc ]] || touch .envrc && " + 
          "sed -i '/^source .*vault.*.env$/d' .envrc || true && " +
          "echo 'source ${config.xdg.configHome}/secrets/vault.prod.env' >> .envrc ";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "dotenv" "kubectl" "history" "docker" ];
        theme = "robbyrussell";
      };
    };
    programs.autojump = {
      enable = true;
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
    # dconf.enable = true;
    # dconf.settings = {
    #   "org/gnome/settings-daemon/plugins/media-keys" = {
    #     custom-keybindings = [
    #       "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    #       "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    #     ];
    #   };
    #   "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    #     binding = "<Ctrl>space";
    #     command = "albert toggle";
    #     name = "albert-toggle";
    #   };
    #   "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
    #     binding = "<Super>t";
    #     command = "alacritty";
    #     name = "alacritty";
    #   };
    # };
    services.gpg-agent.enable = true;
    programs.gpg.enable = true;
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    # xdg.enable = true;
    # xdg.configFile."albert/albert.conf".text = ''
    #   [General]
    #   hotkey=Ctrl+Space
    #   showTray=true
    #   terminal=alacritty -e
    #   autostartOnLogin=true
    #   
    #   [org.albert.extension.applications]
    #   enabled=true
    #   
    #   [org.albert.extension.calculator]
    #   enabled=true
    #   
    #   [org.albert.extension.files]
    #   enabled=false
    #   
    #   [org.albert.extension.hashgenerator]
    #   enabled=true
    #   
    #   [org.albert.extension.ssh]
    #   enabled=false
    #   
    #   [org.albert.extension.system]
    #   enabled=true
    #   
    #   [org.albert.extension.terminal]
    #   enabled=true
    #   
    #   [org.albert.extension.websearch]
    #   enabled=false
    #   
    #   [org.albert.frontend.widgetboxmodel]
    #   alwaysOnTop=true
    #   clearOnHide=false
    #   displayIcons=true
    #   displayScrollbar=false
    #   displayShadow=true
    #   hideOnClose=false
    #   hideOnFocusLoss=true
    #   itemCount=5
    #   showCentered=true
    #   theme=Bright
    # '';
    home.file."${config.xdg.configHome}/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    # fix for 21.11
    manual.manpages.enable = false;
}
