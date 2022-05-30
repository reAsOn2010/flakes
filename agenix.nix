{ ... }:

{
    age.identityPaths = ["/root/.ssh/id_ed25519"]; 
    age.secrets."yakumo/hashed-password.age".file = secrets/yakumo/hashed-password.age;
    age.secrets."root/hashed-password.age".file = secrets/root/hashed-password.age;
    age.secrets."yakumo/kube-config.age".file = secrets/yakumo/kube-config.age;
}
