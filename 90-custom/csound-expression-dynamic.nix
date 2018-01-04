{ mkDerivation, array, base, Boolean, containers, data-default
, data-fix, data-fix-cse, hashable, stdenv, transformers, wl-pprint
}:
mkDerivation {
  pname = "csound-expression-dynamic";
  version = "0.3.2";
  src = /home/sebastian/src/csound-expression-dynamic;
  libraryHaskellDepends = [
    array base Boolean containers data-default data-fix data-fix-cse
    hashable transformers wl-pprint
  ];
  homepage = "https://github.com/anton-k/csound-expression-dynamic";
  description = "dynamic core for csound-expression library";
  license = stdenv.lib.licenses.bsd3;
}
