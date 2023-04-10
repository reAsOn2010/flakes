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
  clash-config = pkgs.stdenv.mkDerivation rec {
    name = "clash-config";
    src = ./.;
    data = pkgs.fetchurl {
      name = "config.yaml";
      url = "https://suc.eula.club/sub?target=clash&url=https%3A%2F%2Ffast.lycorisrecoil.org%2Flink%2FEvGwXJcsEgejFo66%3Fsub%3D1&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2FACL4SSR%2FACL4SSR%2Fmaster%2FClash%2Fconfig%2FACL4SSR_Online_Mini.ini&emoji=true&list=false&tfo=false&scv=false&fdn=false&sort=false&new_name=true";
      sha256 = "sha256-YiERqopIs4AxqGff2hxQjBhGoCjVj4puz3jvRdfawMI=";
    };
    installPhase = ''
      runHook preInstall
      ls -al
      mkdir -p $out/etc/clash
      install -Dm 0644 $data -D $out/etc/clash/config.yaml
      runHook postInstall
    '';
  };
in
{
  environment.systemPackages = [
    clash-geoip
    clash-config
  ];
  virtualisation.oci-containers.containers = {
    clashboard = {
      image = "haishanh/yacd";
      ports = [ "127.0.0.1:7899:80" ];
    };
    clash = {
      image = "dreamacro/clash";
      volumes = [
        "${clash-geoip}/etc/clash/Country.mmdb:/root/.config/clash/Country.mmdb"
        "${clash-config}/etc/clash/config.yaml:/root/.config/clash/config.yaml"
      ];
      extraOptions = ["--network=host"];
    };
  };
}
