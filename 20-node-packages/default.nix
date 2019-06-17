self: super: {
  customNodePackages = import ./node-packages { pkgs = self; };
  nix-kubernetes = self.customNodePackages."nix-kubernetes-git+https://github.com/seppeljordan/nix-kubernetes.git";
}
