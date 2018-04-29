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
  wrapWithCsound = drv:
    let
      drvName = builtins.parseDrvName drv.name;
    in
      self.stdenv.mkDerivation {
        name = drvName.name + "-wrapped-" + drvName.version;
        buildInputs = [ self.makeWrapper ];
        phases = ["installPhase"];
        inherit drv;
        installPhase = ''
          mkdir -p $out/bin
          makeWrapper ${drv}/bin/geimskell $out/bin/geimskell \
            --prefix PATH : ${self.lib.makeBinPath [ self.csound ]}
        '';
      };
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
      csound-expression-dynamic =
        cleanSource (new.callPackage
        ./csound-expression-dynamic.nix {});
      argparser = super.haskell.lib.dontCheck orig.argparser;
      csound-expression-typed =
        cleanSource (new.callPackage
        ./csound-expression-typed.nix {});
    };
  };
  haskellEnv = self.haskellPackages.ghcWithHoogle
               (p: with p; [
                 argparser
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
  geimskell = self.wrapWithCsound self.haskellPackages.geimskell;
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
      nyan-mode
      paredit
      projectile
      py-isort
      rust-mode
      scala-mode
      xresources-theme
      yaml-mode
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
  customNodePackages = import ./node-packages { pkgs = self; };
  nix-kubernetes = self.customNodePackages."nix-kubernetes-git+https://github.com/seppeljordan/nix-kubernetes.git";
  nixops = super.nixops.overrideDerivation (
    old: {
      patchPhase = ''
        substituteInPlace nix/eval-machine-info.nix \
            --replace 'system.nixosVersion' 'system.nixos.version'
      '';
    }
  );
}
