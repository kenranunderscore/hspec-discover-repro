{ sources ? import ./nix/sources.nix }:

let
  pkgs = import ./nix/pkgs.nix { inherit sources; };
  env = pkgs.haskellPackages.hspec-discover-repro.env;
in pkgs.lib.overrideDerivation env (old: {
  nativeBuildInputs = old.nativeBuildInputs ++ [ pkgs.cabal-install pkgs.ghc ];
})
