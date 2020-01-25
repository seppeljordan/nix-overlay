with import <nixpkgs> { };
buildEnv {
  name = "test-env";
  paths = [ haskellEnv ];
}
