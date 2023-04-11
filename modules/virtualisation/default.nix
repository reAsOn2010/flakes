{ pkgs, config, ... }:
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
      defaultNetwork.dnsname.enable = true;
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
