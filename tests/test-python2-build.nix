with import <nixpkgs> { };
buildEnv {
  name = "test-env";
  paths = [ pypiPackages2.interpreter ];
}
