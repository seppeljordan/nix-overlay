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
    sha256 = "1skxnqwmyqqnikkyzw4rxfa5xc16jhp8lrh2zzvb32pilnk7z8j3";
    rev = "d5d44cee3446ef506358f92229c7a6fa55b2269e";
    fetchSubmodules = true;
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
  testHaskellDepends = [
    base hspec htiled QuickCheck random reactive-banana sdl2
    transformers
  ];
  license = stdenv.lib.licenses.gpl3;
}
