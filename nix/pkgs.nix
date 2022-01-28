{ sources ? import ./sources.nix }:

let
  overlay = hfinal: hprev: {
    hspec-discover-repro = hfinal.callCabal2nix "hspec-discover-repro" ../. { };
  };
in import sources.nixpkgs {
  overlays = [
    (final: prev: {
      haskellPackages = prev.haskellPackages.override (old: {
        overrides =
          prev.lib.composeExtensions (old.overrides or (_: _: { })) overlay;
      });
    })
  ];
}
