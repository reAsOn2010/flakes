{ config, lib, pkgs, ... }:
let
  rustdesk-nightly = pkgs.rustPlatform.buildRustPackage rec {
    name = "rustdesk-nightly";
    src = pkgs.fetchFromGitHub {
      owner = "rustdesk";
      repo = "rustdesk";
      rev = "52ce3dd2c299e262a54af0b5350fa60f66215e60";
      sha256 = "sha256-gGSwk/CigmJvoNK9nBPgmcXabQxJiAaWPhNwNeT7rgY=";
    };

    cargoSha256 = lib.fakeSha256;

    buildInputs = [
      pkgs.pkg-config
      pkgs.pango
      pkgs.gtk3
      pkgs.libnotify
      pkgs.libappindicator-gtk3
      # pkgs.adwaita-icon-theme
      pkgs.glibcLocales
      pkgs.xorg.libXScrnSaver
      pkgs.gnutls
      pkgs.libxkbcommon
      pkgs.wayland
      pkgs.libinput
      pkgs.mesa
      # pkgs.glutin
      pkgs.cargo
    ];

    buildPhase = ''
      cargo build --release
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp target/release/rustdesk $out/bin/
    '';

    # meta = with pkgs.meta; {
    #   description = "RustDesk is a remote desktop client for the Rust programming language.";
    #   homepage = "https://github.com/rustdesk/rustdesk";
    #   license = licenses.mit;
    #   platforms = platforms.unix;
    # };
  };
in
{
  environment.systemPackages = with pkgs; [
    # rustdesk
    rustdesk-nightly
  ];
  nixpkgs.overlays = [
    (final: prev: {
      rustdesk =
        prev.rustdesk.overrideAttrs (oldAttrs: {
          src = pkgs.fetchFromGitHub {
            owner = "rustdesk";
            repo = "rustdesk";
            rev = "c14619ef1f2aa81ca18bfa4782556b7aa143d053";
            sha256 = "sha256-IBXS3pXBTbgae+E6N/K/6k9ic9z2US5VtDxfoFSRd4s=";
          };
          # cargoSha256 = "0000000000000000000000000000000000000000000000000000";
          patches = [];
        });
    })
  ];
}
