{ pkgs, lib, ... }:
let
  anydesk-autostart = (pkgs.makeAutostartItem { name = "AnyDesk"; package = pkgs.anydesk; });
in
{
  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    # displayManager.autoLogin.enable = true;
    # displayManager.autoLogin.user = "yakumo";
    libinput.mouse.accelProfile = "flat";
    libinput.mouse.accelSpeed = "0";
    libinput.mouse.middleEmulation = false;
  };

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
  ];

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    kbdInteractiveAuthentication = false;
  };

  services.openvpn.servers = {
    dev = {
      config = '' config /tmp/openvpn/dev.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
    prod = {
      config = '' config /tmp/openvpn/prod.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };

  environment.gnome.excludePackages = (with pkgs.gnome; [
    cheese
    epiphany
    tali
    iagno
    hitori
    atomix
  ]);
  environment.sessionVariables = rec {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "fcitx";
    PATH = [
      "\${HOME}/.config/scripts"
    ];
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # i18n.inputMethod.enabled = "fcitx5";
  # i18n.inputMethod.fcitx5.addons = with pkgs; [
  #   fcitx5-rime
  #   fcitx5-chinese-addons
  # ];

  # i18n.inputMethod.enabled = "ibus";
  # i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; 
  # [
  #   libpinyin
  #   rime
  # ];

  environment.systemPackages = with pkgs; [
    nix-index
    patchelf
    exfat
    (callPackage "${builtins.fetchTarball {
      url = "https://github.com/ryantm/agenix/archive/main.tar.gz";
      sha256 = "1531pvm4wajhmqri99vd12xamlgccv46hzzb66sks6q22x74wczw";
    }}/pkgs/agenix.nix"
      { })
    gnome.networkmanager-openvpn
    gnomeExtensions.system-monitor
    gnomeExtensions.appindicator
    gnomeExtensions.topicons-plus
    gnome3.adwaita-icon-theme
    waybar
    zlib
  ];

  fonts.fonts = with pkgs; [
    dejavu_fonts
    source-sans-pro
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
  fonts.fontconfig.enable = true;

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.dnsname.enable = true;
    };
  };

  networking.extraHosts = ''
    10.222.252.1 cls-aivkqtcv.ccs.tencent-cloud.com
    10.233.252.1 cls-mhktarmn.ccs.tencent-cloud.com
  '';
  networking.firewall.allowedUDPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
  networking.firewall.allowedUDPPorts = [
    80
    443
    6568
    21118
    24800
  ];
  networking.firewall.allowedTCPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
  networking.firewall.allowedTCPPorts = [
    80
    443
    6568
    21118
    24800
  ];

  programs.steam = {
    enable = true;
  };
  # https://github.com/nix-community/home-manager/issues/2991
  programs.zsh = {
    enable = true;
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  security.polkit.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # waybar
  nixpkgs.overlays = [
    (final: prev: {
      waybar =
        let
          hyprctl = "${pkgs.hyprland}/bin/hyprctl";
          waybarPatchFile = import ./workspace-patch.nix { inherit pkgs hyprctl; };
        in
        prev.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
          patches = (oldAttrs.patches or [ ]) ++ [ waybarPatchFile ];
          # postPatch = (oldAttrs.postPatch or "") + ''
          #   sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
          # '';
        });
    })
  ];
}
