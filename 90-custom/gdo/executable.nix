{ stdenv,
  haskellPackages,
  pandoc,
  cabal-install
}:
let
  version = (builtins.parseDrvName (haskellPackages.gdo.name)).version;
  ghcEnvironment = haskellPackages.ghcWithPackages( p: with p; [
      process
      filepath
      directory
      containers
      cryptohash
      transformers
      bytestring
      gdo
    ]);
in
stdenv.mkDerivation {
  name = "gdo-${version}";
  src = haskellPackages.gdo.src;
  buildInputs = [
    cabal-install
    pandoc
    ghcEnvironment
  ];
  builder = ./build-executable.sh;
  inherit version;
}
