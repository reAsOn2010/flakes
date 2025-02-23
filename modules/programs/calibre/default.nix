{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (calibre.override {
      unrarSupport = true;
    })
  ];
}
