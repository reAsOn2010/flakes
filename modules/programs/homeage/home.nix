{ config, pkgs, inputs, user, ... }:
{
  imports = [
    inputs.homeage.homeManagerModules.homeage
  ];
  homeage = {
    identityPaths = [ "~/.ssh/id_ed25519" ];
    installationType = "systemd";
    file."kube-config" = {
      source = ../../../secrets/yakumo/kube-config.age;
      copies = [ "/home/${user}/.kube/config" ];
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
      symlinks = [ "/home/${user}/.docker/config.json" ];
    };
    file."dbeaver.credentials-config.json" = {
      source = ../../../secrets/yakumo/dbeaver/credentials-config.json.age;
      copies = [ "${config.xdg.dataHome}/DBeaverData/workspace6/General/.dbeaver/credentials-config.json" ];
      mode = "0600";
    };
    file."dbeaver.data-sources.json" = {
      source = ../../../secrets/yakumo/dbeaver/data-sources.json.age;
      copies = [ "${config.xdg.dataHome}/DBeaverData/workspace6/General/.dbeaver/data-sources.json" ];
      mode = "0600";
    };
    file."dbeaver.project-settings.json" = {
      source = ../../../secrets/yakumo/dbeaver/project-settings.json.age;
      copies = [ "${config.xdg.dataHome}/DBeaverData/workspace6/General/.dbeaver/project-settings.json" ];
      mode = "0600";
    };
    file."rclone.rclone.conf" = {
      source = ../../../secrets/yakumo/rclone/rclone.conf.age;
      copies = [ "${config.xdg.configHome}/rclone/rclone.conf" ];
      mode = "0600";
    };
  };
}
