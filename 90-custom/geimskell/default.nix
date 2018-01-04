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
    sha256 = "00y2wvmcqzp375ina325rc9mn8m57vkzphyj7s8ssv2pi6423kmz";
    rev = "e1fb6c467fe971e789dc4d9eabec5a44c6fa0e7c";
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
