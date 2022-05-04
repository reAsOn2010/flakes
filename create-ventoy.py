import hashlib
import os
import tarfile
import urllib.request

VENTOY_VERSION = "1.0.74"

base_url = "https://github.com/ventoy/Ventoy/releases/download/v{version}".format(version=VENTOY_VERSION)
filename = "ventoy-{version}-linux.tar.gz".format(version=VENTOY_VERSION)
checksum_filename = "sha256.txt"
urllib.request.urlretrieve("/".join([base_url, checksum_filename]), checksum_filename)
urllib.request.urlretrieve("/".join([base_url, filename]), filename)


def verify(filename, checksum_file):
    hash_store = hashlib.sha256()
    hash_store.update(open(filename, "rb").read())
    checksum = hash_store.hexdigest()
    match = False
    with open(checksum_file, "r") as f:
        for line in f.readlines():
            if filename in line and checksum in line:
                match = True

    if not match:
        print("Verify {file} failed.".format(file=filename))
        exit(1)


verify(filename, checksum_filename)
tarfile.open(filename).extractall()

os.system("lsblk | grep disk")
print("")

dev = input("Please input which device to install ventoy: ")
os.system("sudo ventoy-{version}/Ventoy2Disk.sh -I /dev/{dev}".format(version=VENTOY_VERSION, dev=dev))
os.system("mkdir ./mnt")
os.system("sudo mount /dev/{dev}1 ./mnt".format(dev=dev))

NIXOS_VERSION = "21.11"
base_url = "https://channels.nixos.org/nixos-{version}/".format(version=NIXOS_VERSION)
filename = "latest-nixos-gnome-x86_64-linux.iso"
checksum_filename = "latest-nixos-gnome-x86_64-linux.iso.sha256"

urllib.request.urlretrieve("/".join([base_url, filename]), filename)
urllib.request.urlretrieve("/".join([base_url, checksum_filename]), checksum_filename)

verify(filename, checksum_filename)
