{ config, pkgs, inputs, user, ... }:
{
  environment.systemPackages = with pkgs; [
    scrcpy
  ];
  programs.adb.enable = true;
  users.users.${user}.extraGroups = ["adbusers"];
  # virtualisation.oci-containers.containers = {
  #   redroid = {
  #     image = "redroid/redroid:11.0.0-latest";
  #     ports = [ "5555:5555" ];
  #     volumes = [ "/home/${user}/Documents/redroid:/data" ];
  #     extraOptions = ["--privileged"];
  #     cmd = [ 
  #       # "androidboot.redroid_width=1024"
  #       # "androidboot.redroid_height=768"
  #       "androidboot.redroid_gpu_mode=host"
  #       # "androidboot.redroid_dpi=480"
  #       "andriodboot.redriod_fps=30"
  #       "andriodboot.use_memfd=true"
  #     ];
  #   };
  # };
}
