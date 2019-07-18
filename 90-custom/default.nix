self: super:
let
  makeThreadedHaskell = drv: drv.overrideDerivation( old:
    let
      oldFlags = if builtins.hasAttr "configureFlags" old
        then old.configureFlags else [];
    in
      {
        configureFlags = oldFlags ++ ["--ghc-option=-threaded"];
      });
  deletePipSymlink = drv: drv.overrideDerivation(old:
    {
      postInstall = old.postInstall + ''
        rm $out/bin/pip
      '';
    });
  cleanSource = drv: drv.overrideDerivation(old:
    {
      src = self.lib.cleanSource old.src;
    });
in
{
  gdo-exec = self.callPackage gdo/executable.nix {};
  haskellPackages = super.haskellPackages.override {
    overrides = new: orig: {
      nixgui = new.callPackage ./nixgui {};
      lrucache = new.callPackage ./lrucache {};
      MonadStack = new.callPackage ./MonadStack {};
      sdl2-compositor = new.callPackage ./sdl2-compositor/default.nix {};
      geimskell = makeThreadedHaskell
        (new.callPackage ./geimskell {});
      htiled = new.callPackage ./htiled {};
      argparser = super.haskell.lib.dontCheck orig.argparser;
      sdl2 = super.haskell.lib.dontCheck orig.sdl2;
    };
  };
  haskellEnv = self.haskellPackages.ghcWithHoogle
               (p: with p; [
                 # currently broken
                 # argparser
                 base
                 cabal-install
                 doctest
                 hspec
                 htiled
                 lrucache
                 mtl
                 parsec
                 QuickCheck
               ]);
  pypiPackages = self.pypiPackages3;
  display-config = self.callPackage ./display-config {};
  geimskell = self.haskellPackages.geimskell;
  emacsEnv = self.emacsWithPackages
    (p: with p; [
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
      elpy
    ]);
  wineWow = self.wineUnstable.override { wineBuild = "wineWow"; };
  winetricks =
    let
      useWineWow = drv: drv.override { wine = self.wineWow; };
      useCustomSource = drv: drv.overrideDerivation( old: {
        src = with builtins; with self;
          fetchFromGitHub (fromJSON (readFile winetricks/source.json));
      });
    in
      (useCustomSource (useWineWow super.winetricks));
    nix-prefetch-github = super.nix-prefetch-github.overrideDerivation( old: rec {
      name = "nix-prefetch-github-${version}";
      version = "2.3";
      src = super.fetchFromGitHub {
        owner = "seppeljordan";
        repo = "nix-prefetch-github";
        rev = "v${version}";
        sha256 = "0b2hgfyxhlqq6lyi5cr98dz6if5kl6b3kq67f2lzfkalydywl1dh";
      };
    });
}
