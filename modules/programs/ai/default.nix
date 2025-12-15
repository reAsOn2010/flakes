{ config, pkgs, inputs, user, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
    acceleration = false; 
    loadModels = [
      "deepseek-r1:1.5b"
      "qwen3:1.7b"
    ];
  };
}
