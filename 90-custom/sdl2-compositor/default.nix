{ mkDerivation, base, Cabal, hspec, hspec-core, lens, linear
, lrucache, QuickCheck, sdl2, StateVar, stdenv, stm, text
, transformers
}:
mkDerivation {
  pname = "sdl2-compositor";
  version = "1.2.0.7";
  sha256 = "1yfbqxrfhy951qdcf43vx9gxd4jj3l2dq5bz04blchpq4qzm4876";
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base lens linear lrucache QuickCheck sdl2 StateVar stm text
    transformers
  ];
  testHaskellDepends = [
    base Cabal hspec hspec-core lrucache QuickCheck stm
  ];
  description = "image compositing with sdl2 - declarative style";
  license = stdenv.lib.licenses.gpl3;
}
