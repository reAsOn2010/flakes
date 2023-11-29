{ pkgs, hostName, ... }:
rec {
  primary = {
    "home" = "HDMI-A-1";
    "pat" = "HDMI-A-2";
  }."${hostName}";
  left = {
    "home" = "DP-1";
    "pat" = "DP-1";
  }."${hostName}";
  hypr-monitor-conf = pkgs.substituteAll {
    name = "hypr-monitor.conf";
    src = ./${hostName}.conf;
    primary = "${primary}";
    left = "${left}";
  };
}
