{ pkgs, hostName, ... }:
rec {
  monitor = {
    primary = {
      "home" = {
        name = "DP-1";
        position = "1920x0";
        transform = 0;
      };
      "pat" = {
        name = "HDMI-A-2";
        position = "1080x420";
        transform = 0;
      };
    }."${hostName}";
    left = {
      "home" = {
        name = "HDMI-A-1";
        position = "0x0";
        transform = 0;
      };
      "pat" = {
        name = "DP-1";
        position = "0x0";
        transform = 3;
      };
    }."${hostName}";
  };
  envs = {
    "home" = ''
      hl.env("VDPAU_DRIVER", "va_gl")
      hl.env("LIBVA_DRIVER_NAME", "nvidia")
      hl.env("XDG_SESSION_TYPE", "wayland")
      hl.env("GBM_BACKEND", "drm")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
      hl.env("WLR_NO_HARDWARE_CURSORS", "1")
    '';
    "pat" = "";
  }."${hostName}";
}
