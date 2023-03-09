{ config, pkgs, user, ... }:
{
  services.openvpn.servers = {
    dev = {
      config = '' config /home/${user}/.config/openvpn/dev.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
    prod = {
      config = '' config /home/${user}/.config/openvpn/prod.ovpn '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
}
