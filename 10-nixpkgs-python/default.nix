let
  nixpkgs-python-repo = fetchTarball {
    url = "https://github.com/garbas/nixpkgs-python/archive/master.tar.gz";
  };
in
import "${nixpkgs-python-repo}/overlay.nix"
