{ pkgs, config, user, ... }:
# let
#   socketPath = "${config.services.traefik.dataDir}/podman.sock";
# in
{
  virtualisation.oci-containers.backend = "docker";
  virtualisation = {
    docker.enable = true;
    virtualbox = {
      host.enable = true;
    };
  };
  services.traefik = {
    enable = true;
    group = "docker";
    staticConfigOptions = {
      providers.docker = {
        endpoint = "unix://var/run/docker.sock";
      };
    };
  };
}
