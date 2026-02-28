{ config, pkgs, inputs, user, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama;
    acceleration = false; 
    loadModels = [
      "deepseek-r1:1.5b"
      "deepseek-r1:7b"
      "qwen3:1.7b"
      "qwen3:8b"
      "bge-m3:567m"
    ];
  };
}
