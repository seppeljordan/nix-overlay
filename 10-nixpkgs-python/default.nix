self: super:
let
  repo_data = with builtins; fromJSON (readFile ./nixpkgs-python.json);
  repo = self.fetchFromGitHub repo_data;
in { pythonNEXT = import "${repo}" { pkgs = super; }; }
