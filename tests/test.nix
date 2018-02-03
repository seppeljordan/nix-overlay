import <nixpkgs/nixos/tests/make-test.nix>
{
  name = "overlay-test";
  nodes = {
    machine = {config, pkgs, ...}:
    let
      python2Env =
        import ../10-python2Packages/python2.nix { inherit pkgs; };
      python3Env =
        import ../10-python3Packages/python3.nix { inherit pkgs; };
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
