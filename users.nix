{ config, lib, pkgs, ... }:

let
    readHashedPassword = lib.fileContents;
in

{
  users.mutableUsers = false;

  users.users = {
    yakumo = {
      uid = 1000;
      isNormalUser = true;
      description = "yakumo (Shaolei Zhou)";
      home = "/home/yakumo";
      createHome = true;
      group = "users";
      extraGroups = ["wheel"];
      passwordFile = config.age.secrets."yakumo/hashed-password.age".path;
      # openssh.authorizedKeys.keyFiles = [./secrets/users/yakumo/yakumo.pub];
    };
    root = {
      # passwordFile = config.age.secrets."root/hashed-password.age".path;
    };
  };
}
