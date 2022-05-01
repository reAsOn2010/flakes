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
      hashedPassword = readHashedPassword ./secrets/users/yakumo/hashed-password;
      openssh.authorizedKeys.keyFiles = [./secrets/users/yakumo/yakumo.pub];
    };
    root = {
      hashedPassword = readHashedPassword ./secrets/users/root/hashed-password;
    };
  };
}