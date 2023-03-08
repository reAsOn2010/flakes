{ config, lib, pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
  ];

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

  home-manager.users.${user} = {
    # Home-manager waybar config
    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = builtins.readFile ./style.css;
      settings = [{
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "custom/wall"
          "wlr/workspaces"
          # "mpd"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "backlight"
          "cpu"
          "memory"
          "temperature"
          "network"
          "custom/vpn-dev"
          "custom/vpn-prod"
          "battery"
          "pulseaudio"
          "custom/powermenu"
        ];
        "wlr/workspaces" = {
          "format" = "{icon}";
          "on-click" = "activate";
        };
        "clock" = {
          "interval" = 1;
          "format" = "{: %R   %d/%m}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "tray" = {
          "icon-size" = 13;
          "spacing" = 10;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon} {percent}%";
          "format-icons" = [ "" "" "" "" ];
        };
        "cpu" = {
          "format" = " {usage}%";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "﬙ {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "tooltip" = false;
        };
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = " ﴔ ";
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
          "tooltip" = false;
        };
        "custom/vpn-dev" = {
          "exec" = "$HOME/.config/waybar/scripts/vpn.sh dev";
          "on-click" = "$HOME/.config/waybar/scripts/vpn.sh dev toggle";
          "on-click-right" = "$HOME/.config/waybar/scripts/vpn.sh dev import";
          "return-type" = "json";
          "interval" = 60;
          "format" = "DEV {}";
        };
        "custom/vpn-prod" = {
          "exec" = "$HOME/.config/waybar/scripts/vpn.sh prod";
          "on-click" = "$HOME/.config/waybar/scripts/vpn.sh prod toggle";
          "on-click-right" = "$HOME/.config/waybar/scripts/vpn.sh prod import";
          "return-type" = "json";
          "interval" = 60;
          "format" = "PROD {}";
        };
      }];
    };
    home.file = {
      "${config.xdg.configHome}/waybar/scripts" = {
        source = ./scripts;
        recursive = true;
      };
    };
  };
}
