{ ... }:

{
  age.identityPaths = [
    "/root/.ssh/id_ed25519"
    "/home/yakumo/.ssh/id_ed25519"
  ];
  age.secrets."yakumo/hashed-password.age" = {
    file = secrets/yakumo/hashed-password.age;
  };
  age.secrets."root/hashed-password.age" = {
    file = secrets/root/hashed-password.age;
  };
  age.secrets."yakumo/kube-config.age" = {
    file = secrets/yakumo/kube-config.age;
    owner = "yakumo";
  };
  age.secrets."yakumo/vault.prod.env.age" = {
    file = secrets/yakumo/vault.prod.env.age;
    owner = "yakumo";
  };
  age.secrets."yakumo/vault.dev.env.age" = {
    file = secrets/yakumo/vault.dev.env.age;
    owner = "yakumo";
  };
  age.secrets."yakumo/dev.ovpn.age" = {
    file = secrets/yakumo/dev.ovpn.age;
    owner = "yakumo";
  };
  age.secrets."yakumo/prod.ovpn.age" = {
    file = secrets/yakumo/prod.ovpn.age;
    owner = "yakumo";
  };
}
