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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn the.reason.sake@gmail.com"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCl2Sm4pDmTKDUUnc0bSSBtTag4XIJD3//10FpUSqoEsF9VY+YpZBXQ3MRLpv0xwvfO5gbhP3q8PjAy+kpBz/pn18yGyxo5+MMRzBtjWY4Lzbtk+gjyiZsmKwcvexAGfDJOLjlX/sULp5bRB4fEzOl/nK7PaV9vTVU0pTNuFcIxo87l5uGWGHglffWX7doXPvnxweAx1NjJR83BnNhcxhmrQvq419ID4ZNOhWpb+KfOF6w/iJN3Lm5fJW15FuV0LuIJP3TNrjqzc24Dq9asaGy0ZlkoLnRS8exmyjfEg4Gu5t3eFItoq/SqY5C9J1Cy0VI9i4SY34adu3Msfng8v0PT pat_bob_dev"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCK9Lu/WFOsEUQDE7d8U9xrEEMKuF2kL3utzm4yOSAGouO2UKvveZk73s3xHLSFGPUuqRfZZbNWjLX9/gNkJFvE5+ObegZl0Xlmxsm8NnDVDJfykf+1BGRObKqPUnuahHAtpkakirFfgwkNSSbsA2lizlj8qwdGidW8j1IlfoafOHGNwVuRq5u66UM79Ifv4GGLvfa/RbY9Y7MArtrCMmqAHeBDJzZIxdg6ZmQaE3hutAnAAUCPnYZgN8ASfspx5IXEsgj/r5N8UI/5N+QmmTI/7tU3pwYxPMJPO+wsASY5aPxMKv1qOeC9jglDvVf7xD2vzVxHzS0AWhXDBdd73z2V pat_bob_prod"
      ];
    };
    # root = {
    #   passwordFile = config.age.secrets."root/hashed-password.age".path;
    # };
  };
}
