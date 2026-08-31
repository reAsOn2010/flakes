{ config, pkgs, unstable, ... }:
{
  programs.dsh = {
    enable = true;
    profiles.headless = {
      plugins = [ "@deepseek-ai/dsh-base" "@deepseek-ai/dsh-headless" ];
    };
    profiles.web = {
      plugins = [ 
        "@deepseek-ai/dsh-base"
        "@deepseek-ai/dsh-web-app"
      ];
    };
  };
}
