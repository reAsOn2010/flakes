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
  };
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
