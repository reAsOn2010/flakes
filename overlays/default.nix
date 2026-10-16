[
  # rambox: nixpkgs 里还是 2.6.3（2.x 上游已 EOL），这里换成 3.x
  (final: prev: {
    rambox = prev.callPackage ./rambox { };
  })
]
