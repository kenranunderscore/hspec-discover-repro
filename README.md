# `hspec-discover` doesn't work in some Nix shells

At work we found out that
[hspec-discover](http://hspec.github.io/hspec-discover.html) fails to
be executed when inside our `nix-shell`. The scenario is as follows:

- The project is fully nixified, that is, the package(s) is part of
  the `pkgs.haskellPackages` set, which is done via an overlay.
- The `shell.nix` calls `pkgs.haskellPackages.shellFor` and requests a
  development shell for the package(s).
- `nix-build ./nix/pkgs.nix -A haskellPackages.hspec-discover-repro`
  works.
- `nix-shell --run "cabal test"` fails because the solver seemingly
  cannot find a plan that includes the test suite. It doesn't work
  even though `hspec-discover` is in the `PATH` inside the Nix shell.
- `nix-shell -p cabal-install ghc --run "cabal test"` works, though,
  if `cabal-install` is allowed to use Hackage (for instance by doing
  a `cabal update` beforehand).

## What to do?

- We could try to find out why the executable seemingly cannot be
  found when inside the `shellFor`-generated shell. That is, try to
  understand/follow the path resolution that happens when using
  `build-tool-depends`.
- Check whether it works when not using `shellFor`.
- ?

I don't know of any passable workaround yet.

## Links

There seem to be some related issues, albeit with the
[haskell.nix](https://github.com/input-output-hk/haskell.nix)
infrastructure which I haven't used yet.

- https://github.com/input-output-hk/haskell.nix/issues/398
- https://github.com/input-output-hk/haskell.nix/issues/231
