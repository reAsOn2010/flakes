{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.homeage.homeManagerModules.homeage
  ];
  homeage = {
    identityPaths = [ "~/.ssh/id_ed25519" ];
    installationType = "systemd";
    file."kube-config" = {
      source = ../../../secrets/yakumo/kube-config.age;
      copies = [ "/home/yakumo/.kube/config" ];
      mode = "0600";
    };
    file."vault.dev.env" = {
      source = ../../../secrets/yakumo/vault.dev.env.age;
      symlinks = [ "${config.xdg.configHome}/secrets/vault.dev.env" ];
    };
    file."vault.prod.env" = {
      source = ../../../secrets/yakumo/vault.prod.env.age;
      symlinks = [ "${config.xdg.configHome}/secrets/vault.prod.env" ];
    };
    file."docker.config.json" = {
      source = ../../../secrets/yakumo/docker.config.json.age;
      symlinks = [ "/home/yakumo/.docker/config.json" ];
    };
  };
}
