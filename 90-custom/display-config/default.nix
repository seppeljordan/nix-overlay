{ stdenv, xrandr, makeWrapper, feh }:
let version = "1.0";
in stdenv.mkDerivation {
  name = "display-config-${version}";
  src = ./src;

  buildInputs = [ makeWrapper ];
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/display-work $out/bin/.display-work
    chmod +x $out/bin/.display-work
    makeWrapper $out/bin/.display-work $out/bin/display-work \
      --set PATH "${xrandr}/bin/:${feh}/bin/:$PATH"
  '';
}
