{stdenv}:
let
  version = "1.0";
in stdenv.mkDerivation rec {
  name = "pip-sandbox-${version}";
  inherit version;
  src = ./.;
  installPhase = ''
    mkdir -p $out/bin
    cp $src/pip-sandbox $out/bin/
    chmod +x $out/bin/*
  '';
}
