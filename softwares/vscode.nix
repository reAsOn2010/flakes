{ pkgs, lib, ... }:

let
  inherit (pkgs) vscode-extensions vscode-with-extensions;

  vscode = vscode-with-extensions.override {
    vscodeExtensions = with vsode-extensions; [
      jnoortheen.nix-ide
      ms-python.python
    ];
  };
in
{
  environment.systemPackages = [vscode];
}