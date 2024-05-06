{ pkgs, config, user, ... }:
# let
#   socketPath = "${config.services.traefik.dataDir}/podman.sock";
# in
{
  # docker as container backend
  # virtualisation.oci-containers.backend = "docker";
  # virtualisation = {
  #   docker.enable = true;
  #   virtualbox = {
  #     host.enable = true;
  #   };
  # };
  # services.traefik = {
  #   enable = true;
  #   group = "docker";
  #   staticConfigOptions = {
  #     providers.docker = {
  #       endpoint = "unix://var/run/docker.sock";
  #     };
  #   };
  # };
  # users.users.${user} = {
  #   extraGroups = [ "libvirtd" "docker" "vboxusers" ];
  # };

  # podman as container backend
  virtualisation.oci-containers.backend = "podman";
  virtualisation = {
    podman = {
      enable = true;
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
  users.users.${user} = {
    extraGroups = [ "libvirtd" "podman" "vboxusers" ];
  };
}
