# run nix-env -iA python3
import os
import getpass

if getpass.getuser() != "root":
    print("Please run this script as root.")
    exit(1)


def run(cmd, ignore=False):
    exit_code = os.system(cmd)
    if exit_code != 0 and not ignore:
        print("run %s failed" % cmd)
        exit(exit_code)


run("lsblk")
dev = input("Please input install device: ")

hostname = input("Please input hostname: ")

# partition
run("parted /dev/{dev} -- mklabel gpt".format(dev=dev))
run("parted /dev/{dev} -- mkpart primary 512MiB -1".format(dev=dev))
run("parted /dev/{dev} -- mkpart ESP fat32 1MiB 512MiB".format(dev=dev))
run("parted /dev/{dev} -- set 2 esp on".format(dev=dev))

# format
if dev.startswith("nvme"):
    prefix = "p"
else:
    prefix = ""
run("mkfs.ext4 -L nixos /dev/{dev}{prefix}1".format(dev=dev, prefix=prefix))
run("mkfs.fat -F 32 -n BOOT /dev/{dev}{prefix}2".format(dev=dev, prefix=prefix))

# wait for disk recognized
run("sleep 2")

# mount
run("mount /dev/disk/by-label/nixos /mnt")
run("mkdir -p /mnt/boot")
run("mount /dev/disk/by-label/BOOT /mnt/boot")

# generate config
run("nixos-generate-config --root /mnt")

additional = """
  # additional content by install-os.py
  nix = {
    settings.substituters = [ "https://mirrors.ustc.edu.cn/nix-channels/store" ];
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  networking.hostName = "%s";

""" % hostname

print("""
We will add additional config here.
%s    
""" % additional)
with open("/tmp/additional.txt", "w") as f:
    f.write(additional)
run("sed -i.bak '/^\}$/e cat /tmp/additional.txt' /mnt/etc/nixos/configuration.nix")
run("diff /mnt/etc/nixos/configuration.nix /mnt/etc/nixos/configuration.nix.bak", ignore=True)

input("Continue? : ")

# install
run("nixos-install")
run("reboot")
