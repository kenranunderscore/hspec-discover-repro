{ sources ? import ./nix/sources.nix }:

let pkgs = import ./nix/pkgs.nix { inherit sources; };
in pkgs.haskellPackages.shellFor {
  packages = p: [ p.hspec-discover-repro ];
  nativeBuildInputs =
    [ pkgs.cabal-install pkgs.haskellPackages.hspec-discover ];
}
