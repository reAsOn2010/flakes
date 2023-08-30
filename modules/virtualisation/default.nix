{ pkgs, config, user, ... }:
let
  socketPath = "${config.services.traefik.dataDir}/podman.sock";
in
{
  virtualisation.oci-containers.backend = "podman";
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualbox = {
      host.enable = true;
    };
    # waydroid.enable = true;
    # lxd.enable = true;
  };
  # used for install waydroid script
  # environment.systemPackages = with pkgs; [
  #   python310Packages.inquirerpy
  #   python310Packages.tqdm
  #   python310Packages.requests
  # ];
  services.traefik = {
    enable = true;
    group = "podman";
    staticConfigOptions = {
      providers.docker = {
        endpoint = "unix://run/podman/podman.sock";
      };
    };
  };
}
