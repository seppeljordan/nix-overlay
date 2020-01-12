self: super: {
  haskellEnv = self.haskellPackages.ghcWithHoogle (p:
    with p; [
      # currently broken
      base
      cabal-install
      doctest
      hspec
      lrucache
      mtl
      parsec
      QuickCheck
    ]);
  pypiPackages = self.pypiPackages3;
  display-config = self.callPackage ./display-config { };
  emacsEnv = self.emacsWithPackages (p:
    with p; [
      adoc-mode
      clojure-mode
      cssh
      dockerfile-mode
      elm-mode
      flycheck
      flycheck-haskell
      geiser
      haskell-mode
      htmlize
      less-css-mode
      magit
      markdown-mode
      nix-mode
      nix-sandbox
      nyan-mode
      paredit
      projectile
      py-isort
      racer
      rust-mode
      scala-mode
      xresources-theme
      yaml-mode
    ]);
}
