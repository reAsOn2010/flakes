{ config, pkgs, hostName, ... }:
let
  settings = import ./settings.nix { inherit config pkgs hostName; };
in
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
              background-color: #${config.colorScheme.palette.base03};
              color: #${config.colorScheme.palette.base08};
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
          background-color: #${config.colorScheme.palette.base00};
      }

      tooltip {
          background: #${config.colorScheme.palette.base00};
          border-radius: 10px;
          border-width: 2px;
          border-style: solid;
          border-color: #${config.colorScheme.palette.base03};
      }

      #workspaces button {
          padding: 5px;
          color: #${config.colorScheme.palette.base03};
          background: #${config.colorScheme.palette.base00};
          margin-right: 5px;
          border-radius: 10px;
      }

      #workspaces button.active,
      #workspaces button.focused {
          color: #${config.colorScheme.palette.base07};
          background: #${config.colorScheme.palette.base03};
      }

      #workspaces button.urgent {
          color: #${config.colorScheme.palette.base08};
          background: #${config.colorScheme.palette.base03};
      }

      #workspaces button:hover {
          background: #${config.colorScheme.palette.base03};
          color: #${config.colorScheme.palette.base0E};
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
      #mpd,
      #backlight {
          background: #${config.colorScheme.palette.base00};
          padding-left: 5px;
          padding-right: 5px;
      }

      #custom-wallpaper,
      #custom-powermenu,
      #custom-launcher {
          padding-left: 10px;
          padding-right: 10px;
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
          color: #${config.colorScheme.palette.base0A};
      }

      #custom-vpn-dev.active,
      #custom-vpn-prod.active {
          color: #${config.colorScheme.palette.base0B};
      }

      #window {
          padding-left: 50px;
          padding-right: 50px;
          color: #${config.colorScheme.palette.base07};
      }

      #mpd,
      #mpd.stopped {
          color: #${config.colorScheme.palette.base07};
      }
      #mpd.disconnected {
          color: #${config.colorScheme.palette.base03};
      }
      #mpd.paused {
          color: #${config.colorScheme.palette.base0A};
      }
      #mpd.playing {
          color: #${config.colorScheme.palette.base0B};
      }


      #clock {
          color: #${config.colorScheme.palette.base0D};
      }

      #custom-pomo,
      #custom-pomo.pause {
          color: #${config.colorScheme.palette.base03};
      }
      #custom-pomo.work {
          color: #${config.colorScheme.palette.base08};
      }
      #custom-pomo.break {
          color: #${config.colorScheme.palette.base0B};
      }


      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #battery,
      #backlight {
          color: #${config.colorScheme.palette.base0E};
      }

      #custom-wallpaper,
      #custom-powermenu,
      #custom-launcher {
          color: #${config.colorScheme.palette.base0C};
      }
    '';
    settings = [
      settings.primary-setting
      settings.left-setting
    ];
  };
}
