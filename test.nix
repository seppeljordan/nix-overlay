{ system ? builtins.currentSystem }:
with import <nixpkgs/nixos/lib/testing.nix> { inherit system; };
with import <nixpkgs/nixos/lib/qemu-flags.nix>;
with pkgs.lib;
makeTest {
  name = "overlay-test";
  nodes = {
    machine = {config, pkgs, ...}:
    let
      python2Env =
        import 10-python2Packages/python2.nix { pkgs = pkgs; };
      python3Env =
        import 10-python3Packages/python3.nix { pkgs = pkgs; };
    in
    {
      environment.systemPackages = [
        python2Env.interpreter
        python3Env.interpreter
      ];
    };
  };
  testScript = ''
    startAll;

    $machine->shutdown
  '';
}
