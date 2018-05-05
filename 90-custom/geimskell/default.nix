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
    sha256 = "0zhqml0yrjkjbc58gpwc8sznnf59w7mabs4552mpj24cglm37wac";
    rev = "f46220467dab08a04c0e09b8aecf16873fe4cc73";
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
