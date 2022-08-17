{ config, lib, pkgs, ... }:

{
  users.mutableUsers = false;

  users.groups.lrun = {
    gid = 593;
  };
  users.users = {
    yakumo = {
      uid = 1000;
      isNormalUser = true;
      description = "yakumo (Shaolei Zhou)";
      home = "/home/yakumo";
      createHome = true;
      group = "users";
      extraGroups = ["wheel" "lrun"];
      passwordFile = config.age.secrets."yakumo/hashed-password.age".path;
      # openssh.authorizedKeys.keyFiles = [./secrets/users/yakumo/yakumo.pub];
    };
    # root = {
    #   passwordFile = config.age.secrets."root/hashed-password.age".path;
    # };
  };
}
