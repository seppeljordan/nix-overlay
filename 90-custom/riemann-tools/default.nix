let
  _nixpkgs = import <nixpkgs> {};
in
{ stdenv ? _nixpkgs.stdenv
, bundlerEnv ? _nixpkgs.bundlerEnv
, ruby ? _nixpkgs.ruby
, executables ? [
    "riemann-apache-status"
    "riemann-dir-files-count"
    "riemann-freeswitch"
    "riemann-memcached"
    "riemann-portcheck"
    "riemann-bench"
    "riemann-dir-space"
    "riemann-haproxy"
    "riemann-net"
    "riemann-proc"
    "riemann-cloudant"
    "riemann-diskstats"
    "riemann-health"
    "riemann-nginx-status"
    "riemann-varnish"
    "riemann-consul"
    "riemann-fd"
    "riemann-kvminstance"
    "riemann-ntp"
    "riemann-zookeeper"
  ]
, writeScript ? _nixpkgs.writeScript
}:
let
  # the magic which will include gemset.nix
  gems = bundlerEnv {
    name = "riemann-tools-env";
    inherit ruby;
    gemdir  = ./.;
  };
  createExecutable = name: writeScript "${name}-exec" ''
    #!${stdenv.shell}
    exec ${gems}/bin/bundle exec ${ruby}/bin/ruby ${gems}/bin/${name} "$@"
  '';
  copyExecutable = name: ''
    cp ${createExecutable name} $out/bin/${name}
  '';
  createExecutablesForPackage = with builtins;
    concatStringsSep "\n"
    (map copyExecutable executables);
in stdenv.mkDerivation {
  name = "riemann-tools";
  src = ./.;
  buildInputs = [gems ruby];
  installPhase = ''
    mkdir -p $out/bin
    ${createExecutablesForPackage}
  '';
}
