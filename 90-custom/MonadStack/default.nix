{ mkDerivation, base, fetchgit, mtl, stdenv }:
mkDerivation {
  pname = "MonadStack";
  version = "0.1.0.3";
  src = fetchgit {
    url = "https://github.com/seppeljordan/MonadStack.git";
    sha256 = "0amm28q9illw32i0qnk7s35q3dczihay0ly503rixbzrcnr73lhm";
    rev = "46a8c3e29847ce498e18631733a652beea8935e3";
  };
  libraryHaskellDepends = [ base mtl ];
  homepage = "https://github.com/bhurt/MonadStack";
  description = "Generalizing lift to monad stacks";
  license = stdenv.lib.licenses.bsd2;
}
