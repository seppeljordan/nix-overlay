self: super:
let
  repo = self.fetchFromGitHub {
    owner = "garbas";
    repo = "nixpkgs-python";
    rev = "8fe3c0cae01de79e2dbc98660d177e26a3df8cde";
    sha256 = "0dbalc4smg5981pv2f1vczvfyf3sdhcmccwvcbpq684qg82zhxnk";
  };
in
{
  pythonNEXT = import "${repo}" { pkgs = super; };
}
