{ config, pkgs, ... }:
{
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
        "custom/wallpaper"
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
        "active-only" = false;
        "all-outputs" = true;
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
        "on-click" = "pkill rofi || rofi-launcher";
        "tooltip" = false;
      };
      "custom/wallpaper" = {
        "on-click" = "dlwallpaper";
        "format" = " ﴔ ";
      };
      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill rofi || rofi-power";
        "tooltip" = false;
      };
      "custom/vpn-dev" = {
        "exec" = "vpnctl dev";
        "on-click" = "vpnctl dev toggle";
        "on-click-right" = "vpnctl dev import";
        "return-type" = "json";
        "interval" = 10;
        "format" = "DEV {}";
      };
      "custom/vpn-prod" = {
        "exec" = "vpnctl prod";
        "on-click" = "vpnctl prod toggle";
        "on-click-right" = "vpnctl prod import";
        "return-type" = "json";
        "interval" = 10;
        "format" = "PROD {}";
      };
    }];
  };
}
