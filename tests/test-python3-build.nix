with import <nixpkgs> { };
buildEnv {
  name = "test-env";
  paths = [ pypiPackages3.interpreter ];
}
