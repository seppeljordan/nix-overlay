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
    sha256 = "050mgvxjmgp5pifrbw2bdbl3zmmghri0lafxxyxgs31ikzgiagm4";
    rev = "cab7019335936c633f5a5bed3e63c1d06a757f64";
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
  testHaskellDepends = [ base hspec htiled QuickCheck ];
  license = stdenv.lib.licenses.gpl3;
}
