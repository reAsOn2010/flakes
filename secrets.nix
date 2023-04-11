let
  yakumo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjRl7mQftJ4LsWxWbNufQ22IFMiRdxJfukQvyXBhyWn";
in
{
  "secrets/yakumo/hashed-password.age".publicKeys = [ yakumo ];
  "secrets/root/hashed-password.age".publicKeys = [ yakumo ];
  "secrets/yakumo/kube-config.age".publicKeys = [ yakumo ];
  "secrets/yakumo/vault.dev.env.age".publicKeys = [ yakumo ];
  "secrets/yakumo/vault.prod.env.age".publicKeys = [ yakumo ];
  "secrets/yakumo/docker.config.json.age".publicKeys = [ yakumo ];
  "secrets/yakumo/dbeaver/data-sources.json.age".publicKeys = [ yakumo ];
  "secrets/yakumo/dbeaver/credentials-config.json.age".publicKeys = [ yakumo ];
  "secrets/yakumo/clash/config.yaml.age".publicKeys = [ yakumo ];
}
