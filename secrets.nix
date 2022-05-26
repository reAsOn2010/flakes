let
    yakumo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/aP+BdEdAhZeVxz1VJfDBCyKblMIY4eSiLtfg6ryOw";
in
{
    "secrets/yakumo/hashed-password.age".publicKeys = [ yakumo ];
    "secrets/root/hashed-password.age".publicKeys = [ yakumo ];
}
