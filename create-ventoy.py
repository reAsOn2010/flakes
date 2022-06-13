import hashlib
import os
import shutil
import tarfile
import urllib.request
import getpass

VENTOY_VERSION = "1.0.74"


if getpass.getuser() != "root":
    print("Please run this script as root.")
    exit(1)


def reporthook(a, b, c):
    print("\rdownloading: %5.1f%%" % (a * b * 100.0 / c), end="")
    if (a * b * 100.0 / c) >= 100.0:
        print("")


def verify(file_path, checksum_file_path):
    hash_store = hashlib.sha256()
    hash_store.update(open(file_path, "rb").read())
    checksum = hash_store.hexdigest()
    match = False
    with open(checksum_file_path, "r") as f:
        for line in f.readlines():
            if checksum in line:
                match = True

    if not match:
        print("Verify {file} failed.".format(file=filename))
        exit(1)


base_url = "https://github.com/ventoy/Ventoy/releases/download/v{version}".format(version=VENTOY_VERSION)
filename = "ventoy-{version}-linux.tar.gz".format(version=VENTOY_VERSION)
checksum_filename = "sha256.txt"
urllib.request.urlretrieve("/".join([base_url, checksum_filename]), checksum_filename, reporthook=reporthook)
urllib.request.urlretrieve("/".join([base_url, filename]), filename, reporthook=reporthook)

verify(filename, checksum_filename)
tarfile.open(filename).extractall()

os.system("lsblk | grep disk")
print("")

dev = input("Please input which device to install ventoy: ")
os.system("sudo ventoy-{version}/Ventoy2Disk.sh -I /dev/{dev} -r 2048".format(version=VENTOY_VERSION, dev=dev))
print("Please format preserved space manually. ")
os.system("sudo parted /dev/{dev}".format(dev=dev))
os.system("sudo mkfs.exfat /dev/{dev}3".format(dev=dev))
os.system("mkdir -p ./iso")
os.system("mkdir -p ./files")
os.system("sudo mount /dev/{dev}1 ./iso".format(dev=dev))
os.system("sudo mount /dev/{dev}3 ./files".format(dev=dev))

NIXOS_VERSION = "22.05"
base_url = "https://mirrors.tuna.tsinghua.edu.cn/nixos-images/nixos-{version}".format(version=NIXOS_VERSION)
filename = "latest-nixos-gnome-x86_64-linux.iso"
checksum_filename = "latest-nixos-gnome-x86_64-linux.iso.sha256"

urllib.request.urlretrieve("/".join([base_url, checksum_filename]), "./iso/%s" % checksum_filename,
                           reporthook=reporthook)
urllib.request.urlretrieve("/".join([base_url, filename]), "./iso/%s" % filename, reporthook=reporthook)

verify("./iso/%s" % filename, "./iso/%s" % checksum_filename)

for f in ["build-env.py", "build-env.sh", "install-os.py", "install-os.sh"]:
    shutil.copyfile(f, "./files/%s" % f)
