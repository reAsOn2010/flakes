{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
          * {
          border: none;
          border-radius: 0;
          font-family: monospace;
          font-weight: bold;
          font-size: 14px;
          min-height: 0;
          transition-property: background-color;
          transition-duration: 0.5s;
      }

      @keyframes blink_red {
          to {
              background-color: #${config.colorScheme.colors.base08};
              color: #${config.colorScheme.colors.base00};
          }
      }

      .warning,
      .critical,
      .urgent {
          animation-name: blink_red;
          animation-duration: 1s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      window#waybar {
          background-color: transparent;
      }

      window>box {
          background-color: #${config.colorScheme.colors.base00};
      }

      tooltip {
          background: #${config.colorScheme.colors.base00};
          border-radius: 10px;
          border-width: 2px;
          border-style: solid;
          border-color: #${config.colorScheme.colors.base00};
      }

      #workspaces button {
          padding: 5px;
          color: #${config.colorScheme.colors.base02};
          margin-right: 5px;
          border-radius: 10px;
      }

      #workspaces button.active,
      #workspaces button.focused {
          color: #${config.colorScheme.colors.base04};
          background: #${config.colorScheme.colors.base03};
      }

      #workspaces button.urgent {
          color: #${config.colorScheme.colors.base04};
          background: #${config.colorScheme.colors.base08};
      }

      #workspaces button:hover {
          background: #${config.colorScheme.colors.base04};
          color: #${config.colorScheme.colors.base0B};
      }

      #custom-wallpaper,
      #custom-powermenu,
      #custom-launcher,
      #custom-vpn-dev,
      #custom-vpn-prod,
      #window,
      #clock,
      #cpu,
      #memory,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #temperature,
      #tray,
      #backlight {
          background: #${config.colorScheme.colors.base00};
          padding-left: 5px;
          padding-right: 5px;
      }

      #tray {
          padding-right: 10px;
      }

      #workspaces {
          padding-left: 10px;
      }

      #custom-vpn-dev,
      #custom-vpn-prod,
      #custom-vpn-dev.inactive,
      #custom-vpn-prod.inactive {
          color: #${config.colorScheme.colors.base08};
      }

      #custom-vpn-dev.active,
      #custom-vpn-prod.active {
          color: #${config.colorScheme.colors.base0B};
      }

      #window,
      #clock {
          color: #${config.colorScheme.colors.base07};
      }

      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #battery,
      #backlight {
          color: #${config.colorScheme.colors.base0E};
      }

      #custom-wallpaper,
      #custom-powermenu,
      #custom-launcher {
          color: #${config.colorScheme.colors.base04};
      }
    '';
    # style = builtins.readFile ./style.css;
    settings = [{
      "layer" = "top";
      "position" = "top";
      modules-left = [
        "custom/launcher"
        "custom/wallpaper"
        "wlr/workspaces"
        "hyprland/window"
      ];
      modules-center = [
        "clock"
      ];
      modules-right = [
        "tray"
        # "mpd"
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
        "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        "format-full" = "{icon} {capacity}%";
        "format-charging" = " {capacity}%";
        "tooltip" = false;
      };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-muted" = " Muted";
        # "on-click": "/home/amitgold/.config/hypr/scripts/volume_ctl.sh mute",
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
        "format" = "  ";
        "on-click" = "pkill rofi || rofi-launcher";
        "tooltip" = false;
      };
      "custom/wallpaper" = {
        "on-click" = "dlwallpaper";
        "format" = " ﴔ ";
        "tolltip" = "Download today's bing wallpaper";
      };
      "custom/powermenu" = {
        "format" = "  ";
        "on-click" = "pkill rofi || rofi-power";
        "tooltip" = false;
      };
      "custom/vpn-dev" = {
        "exec" = "vpnctl dev";
        "on-click" = "vpnctl dev toggle";
        "on-click-right" = "vpnctl dev import";
        "return-type" = "json";
        "interval" = 10;
        "format" = "{} DEV";
      };
      "custom/vpn-prod" = {
        "exec" = "vpnctl prod";
        "on-click" = "vpnctl prod toggle";
        "on-click-right" = "vpnctl prod import";
        "return-type" = "json";
        "interval" = 10;
        "format" = "{} PROD";
      };
    }];
  };
}
