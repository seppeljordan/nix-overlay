{ mkDerivation, array, base, containers, csound-expression, deepseq
, directory, fetchgit, hosc, hspec, htiled, lens, linear, mtl
, prelude-safeenum, process, QuickCheck, random, reactive-banana
, sdl2, sdl2-compositor, sdl2-image, StateVar, stdenv, stm, text
, transformers, vector
}:
mkDerivation {
  pname = "geimskell";
  version = "0.1.0.0";
  src = fetchgit {
    url = "https://github.com/seppeljordan/geimskell.git";
    sha256 = "1cvxmb5db8hxd5jf5d2ngl693ghp7hiqv45v4phsy0dri8ksiakk";
    rev = "4e2396aad167e0219e8229a2448ea61686ac1bb6";
  };
  isLibrary = true;
  isExecutable = true;
  enableSeparateDataOutput = true;
  libraryHaskellDepends = [
    array base containers csound-expression deepseq directory hosc
    htiled lens linear mtl prelude-safeenum process QuickCheck random
    reactive-banana sdl2 sdl2-compositor sdl2-image StateVar stm text
    transformers vector
  ];
  executableHaskellDepends = [ base ];
  testHaskellDepends = [ base hspec htiled QuickCheck ];
  license = stdenv.lib.licenses.gpl3;
}
