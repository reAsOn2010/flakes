{ config, pkgs, hostName, ... }:
let
  monitors = import ../../desktop/hyprland/monitors.nix { inherit pkgs hostName; };
  waybar-clock = {
    "interval" = 1;
    "format" = " {:%H:%M:%S   %Y/%m/%d}";
    "tooltip-format" = "<tt><small>{calendar}</small></tt>";
    "calendar" = {
      "mode" = "year";
      "mode-mon-col" = 3;
      "weeks-pos" = "right";
      "on-scroll" = 1;
      "on-click-right" = "mode";
      "format" = {
        "months" = "<span color='#${config.colorScheme.palette.base07}'><b>{}</b></span>";
        "days" = "<span color='#${config.colorScheme.palette.base05}'><b>{}</b></span>";
        "weeks" = "<span color='#${config.colorScheme.palette.base0D}'><b>W{}</b></span>";
        "weekdays" = "<span color='#${config.colorScheme.palette.base0A}'><b>{}</b></span>";
        "today" = "<span color='#${config.colorScheme.palette.base08}'><b><u>{}</u></b></span>";
      };
    };
    "actions" = {
      "on-click-right" = "mode";
      "on-click-forward" = "tz_up";
      "on-click-backward" = "tz_down";
      "on-scroll-up" = "shift_up";
      "on-scroll-down" = "shift_down";
    };
  };

in
{
  primary-setting = {
    "output" = "${monitors.primary}";
    "layer" = "top";
    "position" = "top";
    modules-left = [
      "custom/launcher"
      "custom/wallpaper"
      "hyprland/workspaces"
      # "wlr/workspaces"
      "mpd"
    ];
    modules-center = [
      "clock"
      # "custom/pomo"
    ];
    modules-right = [
      "hyprland/window"
      "tray"
      "custom/vpn-dev"
      "custom/vpn-prod"
      "backlight"
      "cpu"
      "memory"
      "temperature"
      "network"
      "battery"
      "pulseaudio"
      "custom/powermenu"
    ];
    "hyprland/window" = {
      "format" = "{}";
    };
    "hyprland/workspaces" = {
      "sort-by-number" = true;
      "on-click" = "activate";
      "on-scroll-up" = "hyprctl dispatch workspace e+1";
      "on-scroll-down" = "hyprctl dispatch workspace e-1";
      "format" = "{name}";
      "persistent-workspaces" = {
        ${monitors.left} = [ 1 9 ];
        ${monitors.primary} = [ 2 3 4 5 6 7 8 ];
      };
    };
    # "wlr/workspaces" = {
    #   "format" = "{icon}";
    #   "on-click" = "activate";
    #   "active-only" = false;
    #   "all-outputs" = true;
    # };
    "mpd" = {
      # "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist}|{album}|{title}|({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
      "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
      "format-disconnected" = "Disconnected ";
      "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      "interval" = 5;
      "artist-len" = 16;
      "album-len" = 16;
      "title-len" = 16;
      "on-click" = "mpc toggle";
      "on-click-middle" = "mpc random";
      "on-click-right" = "mpc repeat";
      "on-scroll-up" = "mpc prev";
      "on-scroll-down" = "mpc next";
      "consume-icons" = {
        "on" = " "; # Icon shows only when "consume" is on
      };
      "random-icons" = {
        "off" = "<span color='#${config.colorScheme.palette.base03}'></span> "; # Icon grayed out when "random" is off
        "on" = " ";
      };
      "repeat-icons" = {
        "on" = " ";
      };
      "single-icons" = {
        "on" = "1 ";
      };
      "state-icons" = {
        "paused" = "";
        "playing" = "";
      };
      "tooltip-format" = "MPD (connected)";
      "tooltip-format-disconnected" = "MPD (disconnected)";
    };
    "clock" = waybar-clock;
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
      "format" = " {usage}%";
      "tooltip" = false;
    };
    "memory" = {
      "format" = " {percentage}%";
      "states" = {
        "warning" = 85;
      };
    };
    "temperature" = {
      # "hwmon-path"= "${env:HWMON_PATH}";
      "critical-threshold" = 80;
      "tooltip" = false;
      "format" = " {temperatureC}°C";
    };
    "network" = {
      "format-wifi" = " {essid} ({signalStrength}%)";
      "format-ethernet" = " {ipaddr}/{cidr}";
      "tooltip-format" = " {ifname} via {gwaddr}";
      "format-linked" = " {ifname} (No IP)";
      "format-disconnected" = "⚠ Disconnected";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };
    "battery" = {
      "interval" = 10;
      "states" = {
        "warning" = 20;
        "critical" = 10;
      };
      "format" = "{icon} {capacity}%";
      "format-icons" = [ "" "" "" "" "" ];
      "format-full" = "{icon} {capacity}%";
      "format-charging" = " {capacity}%";
      "tooltip" = false;
    };
    "pulseaudio" = {
      "format" = "{icon} {volume}%";
      "format-muted" = " Muted";
      "on-click" = "pamixer -t";
      "scroll-step" = 1;
      "format-icons" = {
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [ "" "" "" ];
      };
    };
    "custom/launcher" = {
      "format" = "";
      "on-click" = "pkill rofi || rofi-launcher";
      "tooltip" = false;
    };
    "custom/wallpaper" = {
      "format" = "";
      "on-click" = "killall wpaperd; wpaperd";
      "tooltip-format" = "switch wallpaper";
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
      "format" = "{icon} DEV";
      "format-icons" = [ "" "" ];
    };
    "custom/vpn-prod" = {
      "exec" = "vpnctl prod";
      "on-click" = "vpnctl prod toggle";
      "on-click-right" = "vpnctl prod import";
      "return-type" = "json";
      "interval" = 10;
      "format" = "{icon} PROD";
      "format-icons" = [ "" "" ];
    };
  };
  left-setting = {
    "output" = "${monitors.left}";
    "layer" = "top";
    "position" = "top";
    modules-left = [
      "custom/launcher"
      "custom/wallpaper"
      # "wlr/workspaces"
      "hyprland/workspaces"
    ];
    modules-center = [
      "clock"
    ];
    modules-right = [
      "hyprland/window"
      "tray"
      "backlight"
      "cpu"
      "memory"
      "temperature"
      "network"
      "battery"
      "pulseaudio"
      "custom/powermenu"
    ];
    "custom/launcher" = {
      "format" = "";
      "on-click" = "pkill rofi || rofi-launcher";
      "tooltip" = false;
    };
    "custom/wallpaper" = {
      "format" = "";
      "on-click" = "killall wpaperd; wpaperd";
      "tooltip-format" = "switch wallpaper";
    };
    "custom/powermenu" = {
      "format" = "";
      "on-click" = "pkill rofi || rofi-power";
      "tooltip" = false;
    };
    "hyprland/workspaces" = {
      "sort-by-number" = true;
      "on-click" = "activate";
      "on-scroll-up" = "hyprctl dispatch workspace e+1";
      "on-scroll-down" = "hyprctl dispatch workspace e-1";
      "format" = "{name}";
      "persistent-workspaces" = {
        ${monitors.left} = [ 1 9 ];
        ${monitors.primary} = [ 2 3 4 5 6 7 8 ];
      };
    };
    # "wlr/workspaces" = {
    #   "format" = "{icon}";
    #   "on-click" = "activate";
    #   "active-only" = false;
    #   "all-outputs" = true;
    # };
    "clock" = waybar-clock;
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
      "format" = " {usage}%";
      "tooltip" = false;
    };
    "memory" = {
      "format" = " {percentage}%";
      "states" = {
        "warning" = 85;
      };
    };
    "temperature" = {
      # "hwmon-path"= "${env:HWMON_PATH}";
      "critical-threshold" = 80;
      "tooltip" = false;
      "format" = " {temperatureC}°C";
    };
    "network" = {
      "format-wifi" = " {essid} ({signalStrength}%)";
      "format-ethernet" = " {ipaddr}/{cidr}";
      "tooltip-format" = " {ifname} via {gwaddr}";
      "format-linked" = " {ifname} (No IP)";
      "format-disconnected" = "⚠ Disconnected";
      "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    };
    "battery" = {
      "interval" = 10;
      "states" = {
        "warning" = 20;
        "critical" = 10;
      };
      "format" = "{icon} {capacity}%";
      "format-icons" = [ "" "" "" "" "" ];
      "format-full" = "{icon} {capacity}%";
      "format-charging" = " {capacity}%";
      "tooltip" = false;
    };
    "pulseaudio" = {
      "format" = "{icon} {volume}%";
      "format-muted" = " Muted";
      "on-click" = "pamixer -t";
      "scroll-step" = 1;
      "format-icons" = {
        "headphone" = "";
        "hands-free" = "";
        "headset" = "";
        "phone" = "";
        "portable" = "";
        "car" = "";
        "default" = [ "" "" "" ];
      };
    };
  };
}


