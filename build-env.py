import os
import signal

signal.signal(signal.SIGPIPE, signal.SIG_DFL)

def run(cmd):
    exit_code = os.system(cmd)
    if exit_code != 0:
        print("run %s failed" % cmd)
        exit(exit_code)

run("mkdir -p /etc/nixos/secrets/users/root")
run("tr -cd '[:alnum:]' < /dev/urandom | head -c16 | mkpasswd -m sha-512 -s > /etc/nixos/secrets/users/root/hashed-password")
run("mkdir -p /etc/nixos/secrets/users/yakumo")
run("mkpasswd -m sha-512 > /etc/nixos/secrets/users/yakumo/hashed-password")

run("rm -rf nixos-config")
run("nix-shell -p git --run \"git clone --depth 1 https://github.com/reAsOn2010/nixos-config.git\"")
run("cp nixos-config/*.nix /etc/nixos/")
run("cp -r nixos-config/softwares /etc/nixos/")
run("nixos-rebuild test")