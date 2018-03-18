with import <nixpkgs> {};

let

  ghc-deriving-via = callPackage ./ghc-deriving-via.nix {};
  ghc-deriving-via-pkgs = with haskell.lib; haskell.packages.ghcHEAD.override {
    ghc = ghc-deriving-via;
    overrides = self : super : {
      mkDerivation = args : super.mkDerivation (args // {
        doCheck = false;
        jailbreak = true;
      });
      # primitive = super.primitive_0_6_3_0;
      # profunctors = super.profunctors_5_2_2;
      text = super.text_1_2_3_0;
      unordered-containers = appendPatch super.unordered-containers ./patches/unordered-containers-0.2.8.0.patch;
      semigroupoids = super.semigroupoids_5_2_2;
      free = super.free_5;
      lens = super.lens_4_16;
    };
  };
  ghc-deriving-via-with-pkgs =
    ghc-deriving-via-pkgs.ghcWithPackages ( pkgs : [
      pkgs.aeson
      pkgs.generic-lens
      pkgs.generics-sop
      pkgs.lens
      pkgs.profunctors
      pkgs.QuickCheck
      pkgs.semigroups
    ]);

in

  ghc-deriving-via-with-pkgs
