{ config, lib, pkgs, ... }:
{
  virtualisation.oci-containers.containers = {
    it-tools = {
      image = "corentinth/it-tools";
      ports = [ "80" ];
      extraOptions = [
        "--label=traefik.http.routers.tools.rule=Host(`tools.localhost`)"
      ];
    };
  };
}
