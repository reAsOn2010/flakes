{ ... }:

{
  age.identityPaths = [
    "/root/.ssh/id_ed25519"
    "/home/yakumo/.ssh/id_ed25519"
  ];
  age.secrets."yakumo/hashed-password" = {
    file = secrets/yakumo/hashed-password.age;
  };
  age.secrets."root/hashed-password" = {
    file = secrets/root/hashed-password.age;
  };
}
