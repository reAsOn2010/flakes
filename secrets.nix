let
    yakumo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn";
in
{
    "secrets/yakumo/hashed-password.age".publicKeys = [ yakumo ];
    "secrets/root/hashed-password.age".publicKeys = [ yakumo ];
    "secrets/yakumo/kube-config.age".publicKeys = [ yakumo ];
    "secrets/yakumo/vault.dev.env.age".publicKeys = [ yakumo ];
    "secrets/yakumo/vault.prod.env.age".publicKeys = [ yakumo ];
    "secrets/yakumo/dev.ovpn.age".publicKeys = [ yakumo ];
    "secrets/yakumo/prod.ovpn.age".publicKeys = [ yakumo ];
    "secrets/yakumo/ovpn-auth.txt.age".publicKeys = [ yakumo ];
}
