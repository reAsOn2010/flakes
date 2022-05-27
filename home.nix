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
      enpass
      dbeaver
      alacritty
      albert
      anydesk
      copyq
      vim
    ];
    programs.git = {
      enable = true;
      userName = "yakumo";
      userEmail = "the.reason.sake@gmail.com";
      extraConfig = {
        core.editor = "vim";
        safe.directory /home/yakumo/nixos-config;
      };
    };
    dconf.enable = true;
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Ctrl>space";
        command = "albert toggle";
        name = "albert-toggle";
      };
    };
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
