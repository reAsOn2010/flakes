{ config, pkgs, user, ... }:
{
  # environment.systemPackages = with pkgs; [
  #   update-systemd-resolved
  # ];
  services.openvpn.servers = {
    dev = {
      config = '' config /home/${user}/.config/openvpn/dev.ovpn '';
      autoStart = false;
      updateResolvConf = true;
      up = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
      down = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
    };
    prod = {
      config = '' config /home/${user}/.config/openvpn/prod.ovpn '';
      autoStart = false;
      updateResolvConf = true;
      up = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
      down = "${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved";
    };
  };
  # programs.update-systemd-resolved.servers = {
  #   dev = {
  #     # config = '' config /home/${user}/.config/openvpn/dev.ovpn '';
  #     includeAutomatically = true;
  #   };
  #   prod = {
  #     # config = '' config /home/${user}/.config/openvpn/prod.ovpn '';
  #     includeAutomatically = true;
  #   };
  # };
}
