{ config, lib, pkgs, ... }:
let
  clash-geoip = pkgs.stdenv.mkDerivation rec {
    name = "clash-geoip";
    src = ./.;
    data = pkgs.fetchurl {
      url = "https://github.com/Dreamacro/maxmind-geoip/releases/download/20230312/Country.mmdb";
      sha256 = "sha256-Y/glz6HUfjox9Mn+gPzA8+tUHqV/KkIInUn4SyajUiE=";
    };
    installPhase = ''
      runHook preInstall
      ls -al
      mkdir -p $out/etc/clash
      install -Dm 0644 $data -D $out/etc/clash/Country.mmdb
      runHook postInstall
    '';
  };
in
{
  networking = {
    hosts = {
      "127.0.0.1" = [ "yacd.localhost" ];
    };
  };
  environment.systemPackages = [
    clash-geoip
  ];
  virtualisation.oci-containers.containers = {
    yacd = {
      image = "haishanh/yacd";
      ports = [ "80" ];
      extraOptions = [
        "--label=traefik.http.routers.yacd.rule=Host(`yacd.localhost`)"
      ];
    };
    clash = {
      image = "dreamacro/clash";
      volumes = [
        "${clash-geoip}/etc/clash/Country.mmdb:/root/.config/clash/Country.mmdb"
        "${config.age.secrets."yakumo/clash/config.yaml".path}:/root/.config/clash/config.yaml"
      ];
      extraOptions = [ "--network=host" ];
    };
  };
}
