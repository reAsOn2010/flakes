{ config, lib, pkgs, inputs, hostName, ... }:
let
  monitors = import ./monitors.nix { inherit pkgs hostName; };
  lua = lib.generators.mkLuaInline;
  dsp = {
    exec = cmd: lua ''hl.dsp.exec_cmd("${cmd}")'';
    close = lua "hl.dsp.window.close()";
    exit = lua "hl.dsp.exit()";
    float = lua ''hl.dsp.window.float({ action = "toggle" })'';
    fullscreen = lua "hl.dsp.window.fullscreen()";
    pseudo = lua "hl.dsp.window.pseudo()";
    layout = msg: lua ''hl.dsp.layout("${msg}")'';
    focus = dir: lua ''hl.dsp.focus({ direction = "${dir}" })'';
    swap = dir: lua ''hl.dsp.window.swap({ direction = "${dir}" })'';
    toggleSpecial = name: lua ''hl.dsp.workspace.toggle_special("${name}")'';
    moveToSpecial = name: lua ''hl.dsp.window.move({ workspace = "special:${name}" })'';
    focusWorkspace = ws: lua ''hl.dsp.focus({ workspace = "${toString ws}" })'';
    moveToWorkspace = ws: lua ''hl.dsp.window.move({ workspace = "${toString ws}" })'';
    drag = lua "hl.dsp.window.drag()";
    resize = lua "hl.dsp.window.resize()";
    sendshortcut = mod: key: lua ''hl.dsp.send_shortcut({ mods = "${mod}", key = "${key}" })'';
  };
  bind = keys: dispatcher: { _args = [keys dispatcher]; };
  bindOpts = keys: dispatcher: opts: { _args = [keys dispatcher opts]; };
  mod = "SUPER";
  workspaceBinds = lib.concatMap (i:
    let key = toString (lib.mod i 10);
    in [
      (bind "SUPER + ${key}" (dsp.focusWorkspace i))
      (bind "SUPER + SHIFT + ${key}" (dsp.moveToWorkspace i))
    ]
  ) (lib.range 1 9);

in
{
  imports = [
    ../../environment/variables.nix
    ../../programs/mako/home.nix
    ../../programs/cliphist/home.nix
    ../../programs/rofi/home.nix
    ../../programs/swayidle/home.nix
    ../../programs/swaylock/home.nix
    # ../../programs/waybar/home.nix
    ../../programs/wpaperd/home.nix
    ../../programs/homeage/home.nix
  ];
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
           start-hyprland
        fi
      '';
    };
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.packages = with pkgs; [
    pantheon.pantheon-agent-polkit
  ];
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        variant = "latte";
      };
      name = "catppuccin";
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
    cursorTheme = {
      package = pkgs.catppuccin-cursors;
      name = "latteBlue";
    };
    # Original config
    # theme = {
    #   package = nix-colors-lib.gtkThemeFromScheme {
    #     scheme = config.colorScheme;
    #   };
    #   name = config.colorScheme.slug;
    # };
    # iconTheme = {
    #   package = pkgs.numix-icon-theme;
    #   name = "numix";
    # };
    # cursorTheme = {
    #   package = pkgs.vanilla-dmz;
    #   name = "Vanilla-DMZ";
    # };
    gtk2.extraConfig = ''
      gtk-im-module="fcitx"
    '';
    gtk3.extraConfig = {
      gtk-im-module = "fcitx";
    };
    gtk4.extraConfig = {
      gtk-im-module = "fcitx";
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    package = null;
    portalPackage = null;
    settings = {
      config = {
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = true;
          };
        };
      };
      monitor = [
        {
          output = "${monitors.left}";
          mode = "prefered";
          position = "0x0";
          scale = "auto";
        } 
        {
          output = "${monitors.primary}";
          mode = "prefered";
          position = "1920x0";
          scale = "auto";
        }
      ];
      bind = [
        # Basic bind
        (bind "${mod} + T" (dsp.exec "alacritty"))
        (bind "${mod} + Q" dsp.close)
        (bind "${mod} + SHIFT + Q" (dsp.exec "rofi-power"))
        (bind "${mod} + CTRL + Q" (dsp.exec "hyprctl kill"))
        (bind "${mod} + V" (dsp.exec "cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
        # "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        (bind "${mod} + F" dsp.fullscreen)
        # "$mainMod, F, fullscreen"
        (bind "${mod} + M" dsp.float)
        # "$mainMod, M, togglefloating"
        (bind "${mod} + R" (dsp.exec "rofi -show run"))
        (bind "${mod} + P" dsp.pseudo)

        # App shortcut
        (bind "CTRL + SPACE" (dsp.exec "rofi-launcher"))
        # "CTRL, Space, exec, rofi-launcher"
        # ", Print, exec, grim -g \"$(slurp)\" $HOME/Pictures/Screenshots/$(date -Iseconds).png"
        # "SHIFT, Print, exec, grim $HOME/Pictures/Screenshots/$(date -Iseconds).png"
      
        # Group mode
        # "$mainMod, G, togglegroup"
        # "$mainMod, TAB, changegroupactive, b"
        # "$mainMod SHIFT, TAB, changegroupactive, f"

        # Move focus
        (bind "${mod} + left" (dsp.focus "left"))
        (bind "${mod} + right" (dsp.focus "right"))
        (bind "${mod} + up" (dsp.focus "up"))
        (bind "${mod} + down" (dsp.focus "down"))
        # "$mainMod, H, movefocus, l"
        # "$mainMod, J, movefocus, d"
        # "$mainMod, K, movefocus, u"
        # "$mainMod, L, movefocus, r"

        # Move window
        (bind "${mod} + SHIFT + left" (dsp.swap "left"))
        (bind "${mod} + SHIFT + right" (dsp.swap "right"))
        (bind "${mod} + SHIFT + up" (dsp.swap "up"))
        (bind "${mod} + SHIFT + down" (dsp.swap "down"))
        # "$mainMod SHIFT, left, movewindow, l"
        # "$mainMod SHIFT, right, movewindow, r"
        # "$mainMod SHIFT, up, movewindow, u"
        # "$mainMod SHIFT, down, movewindow, d"
        # "$mainMod SHIFT, H, movewindow, l"
        # "$mainMod SHIFT, J, movewindow, d"
        # "$mainMod SHIFT, K, movewindow, u"
        # "$mainMod SHIFT, L, movewindow, r"

        # Switch workspaces
        # "$mainMod, 1, workspace, 1"
        # "$mainMod, 2, workspace, 2"
        # "$mainMod, 3, workspace, 3"
        # "$mainMod, 4, workspace, 4"
        # "$mainMod, 5, workspace, 5"
        # "$mainMod, 6, workspace, 6"
        # "$mainMod, 7, workspace, 7"
        # "$mainMod, 8, workspace, 8"
        # "$mainMod, 9, workspace, 9"

        # "$mainMod, comma, workspace, -1"
        # "$mainMod, period, workspace, +1"

        # Move active window to workspace
        # "$mainMod SHIFT, 1, movetoworkspace, 1"
        # "$mainMod SHIFT, 2, movetoworkspace, 2"
        # "$mainMod SHIFT, 3, movetoworkspace, 3"
        # "$mainMod SHIFT, 4, movetoworkspace, 4"
        # "$mainMod SHIFT, 5, movetoworkspace, 5"
        # "$mainMod SHIFT, 6, movetoworkspace, 6"
        # "$mainMod SHIFT, 7, movetoworkspace, 7"
        # "$mainMod SHIFT, 8, movetoworkspace, 8"
        # "$mainMod SHIFT, 9, movetoworkspace, 9"
        # "$mainMod SHIFT, 0, movetoworkspace, 10"
        (bind "${mod} + SHIFT + comma" (dsp.moveToWorkspace "-1"))
        (bind "${mod} + SHIFT + period" (dsp.moveToWorkspace "+1"))
        # "$mainMod SHIFT, comma, movetoworkspace, -1"
        # "$mainMod SHIFT, period, movetoworkspace, +1"

        # Scroll
        (bind "${mod} + mouse_down" (dsp.focusWorkspace "e+1"))
        (bind "${mod} + mouse_up" (dsp.focusWorkspace "e-1"))
        # "$mainMod, mouse_down, workspace, e+1"
        # "$mainMod, mouse_up, workspace, e-1"

        # Move/resize windows
        (bindOpts "${mod} + mouse:272" dsp.drag { mouse = true; })
        (bindOpts "${mod} + mouse:273" dsp.resize { mouse = true; })
        # "$mainMod, mouse:272, movewindow"
        # "$mainMod, mouse:273, resizewindow"

        # Split ratio
        # "$mainMod, bracketleft, splitratio, -0.1"
        # "$mainMod, bracketright, splitratio, +0.1"
      ] ++ workspaceBinds;


      on = {
        _args = [
          "hyprland.start"
          (lua ''
            function()
              hl.exec_cmd("ashell")
              hl.exec_cmd("fcitx5")
              hl.exec_cmd("mkdir -p \"$HOME/cloud\" && rclone mount cos:/main-1318916757 \"$HOME/cloud\" &")
              hl.exec_cmd("nm-applet")
            end'')
        ];
      };
      # exec-once = [
      #   "ashell"
      #   "wpaperd"
      #   "mako"
      #   "fcitx5"
      #   "wl-clipboard-history -t"
      #   "wl-paste --watch cliphist store"
      #   "rm \"$HOME/.cache/cliphist/db\""
      #   "mkdir -p \"$HOME/cloud\" && rclone mount cos:/main-1318916757 \"$HOME/cloud\" &"
      #   "nm-applet &"
      #   "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit"
      # ];

      # workspace = [
      #   "1, monitor:${monitors.left}, persistent:true"
      #   "9, monitor:${monitors.left}, persistent:true"
      #   "2, monitor:${monitors.primary}, persistent:true"
      #   "3, monitor:${monitors.primary}, persistent:true"
      #   "4, monitor:${monitors.primary}, persistent:true"
      #   "5, monitor:${monitors.primary}, persistent:true"
      #   "6, monitor:${monitors.primary}, persistent:true"
      #   "7, monitor:${monitors.primary}, persistent:true"
      #   "8, monitor:${monitors.primary}, persistent:true"
      # ];

      # env = [
      #   ("VDPAU_DRIVER" "va_gl")
      #   ("LIBVA_DRIVER_NAME" "nvidia")
      #   "XDG_SESSION_TYPE,wayland"
      #   "GBM_BACKEND,nvidia-drm"
      #   "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      #   "WLR_NO_HARDWARE_CURSORS,1"
      # ];
    };
    extraConfig = ''
      hl.env("VDPAU_DRIVER", "va_gl")
      hl.env("LIBVA_DRIVER_NAME", "nvidia")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("GBM_BACKEND", "drm")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
      hl.env("WLR_NO_HARDWARE_CURSORS", "1")
    '';
    # extraConfig = builtins.readFile monitors.hypr-monitor-conf + builtins.readFile ./hyprland.conf + ''
    #   exec-once = ${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit
    # '';
  };
}
