self: super:
{
  pypiPackages2 = import ./python2.nix { pkgs = self; };
}
