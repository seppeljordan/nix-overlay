# generated using pypi2nix tool (version: 2.0.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3 -v -E libffi openssl mercurial libxml2 libxslt pkgconfig dbus dbus-glib ncurses cairo gobjectIntrospection --setup-requires pycairo --setup-requires setuptools-scm -r python3.txt --default-overrides --basename python3
#

{ pkgs ? import <nixpkgs> {},
  overrides ? ({ pkgs, python }: self: super: {})
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            if [ -e $out/${pkgs.python3.sitePackages}/pip/req/req_install.py ]; then
              sed -i \
                -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python3.sitePackages}/pip/req/req_install.py
            fi
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ libffi openssl mercurial libxml2 libxslt pkgconfig dbus dbus-glib ncurses cairo gobjectIntrospection ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreterWithPackages = selectPkgsFn: pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (selectPkgsFn pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };

      interpreter = interpreterWithPackages builtins.attrValues;
    in {
      __old = pythonPackages;
      inherit interpreter;
      inherit interpreterWithPackages;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "Babel" = python.mkDerivation {
      name = "Babel-2.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/be/cc/9c981b249a455fa0c76338966325fc70b7265521bad641bf2932f77712f4/Babel-2.6.0.tar.gz";
        sha256 = "8cba50f48c529ca3fa18cf81fa9403be176d374ac4d60738b839122dfaaa3d23";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };

    "Click" = python.mkDerivation {
      name = "Click-7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz";
        sha256 = "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/click/";
        license = licenses.bsdOriginal;
        description = "Composable command line interface toolkit";
      };
    };

    "Flask" = python.mkDerivation {
      name = "Flask-1.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4b/12/c1fbf4971fda0e4de05565694c9f0c92646223cff53f15b6eb248a310a62/Flask-1.0.2.tar.gz";
        sha256 = "2271c0070dbcb5275fad4a82e29f23ab92682dc45f9dfbc22c02ba9b9322ce48";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Click"
        self."Jinja2"
        self."Werkzeug"
        self."itsdangerous"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.com/p/flask/";
        license = licenses.bsdOriginal;
        description = "A simple framework for building complex web applications.";
      };
    };

    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/93/ea/d884a06f8c7f9b7afbc8138b762e80479fb17aedbbe2b06515a12de9378d/Jinja2-2.10.1.tar.gz";
        sha256 = "065c4f02ebe7f7cf559e49ee5a95fb800a9e4528727aec6f24402a5374c65013";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Babel"
        self."MarkupSafe"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jinja.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };

    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.1.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz";
        sha256 = "29872e92839765e546828bb7754a68c418d927cd064fd4708fab9fe9c8bb116b";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/markupsafe/";
        license = "BSD-3-Clause";
        description = "Safely add untrusted strings to HTML/XML markup.";
      };
    };

    "PyGObject" = python.mkDerivation {
      name = "PyGObject-3.32.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/c1/36/c31a6ce9411b22a8ac0759c9b5ffda09368d5e0643450bb8ed83c271588c/PyGObject-3.32.1.tar.gz";
        sha256 = "4165d9fb4157e69c76f29e52a6d73a39a804e18ad9ef0eede15efd9c57c52bf2";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pycairo"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pygobject.readthedocs.io";
        license = "GNU LGPL";
        description = "Python bindings for GObject Introspection";
      };
    };

    "PyNaCl" = python.mkDerivation {
      name = "PyNaCl-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/61/ab/2ac6dea8489fa713e2b4c6c5b549cc962dd4a842b5998d9e80cf8440b7cd/PyNaCl-1.3.0.tar.gz";
        sha256 = "0c6100edd16fefd1557da078c7a31e7b7d7a52ce39fdca2bec29d4f7b6e7600c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cffi"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/pynacl/";
        license = licenses.asl20;
        description = "Python binding to the Networking and Cryptography (NaCl) library";
      };
    };

    "PyYAML" = python.mkDerivation {
      name = "PyYAML-5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9f/2c/9417b5c774792634834e730932745bc09a7d36754ca00acf1ccd1ac2594d/PyYAML-5.1.tar.gz";
        sha256 = "436bc774ecf7c103814098159fbb84c2715d25980175292c648f2da143909f95";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/yaml/pyyaml";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "Pygments" = python.mkDerivation {
      name = "Pygments-2.3.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/64/69/413708eaf3a64a6abb8972644e0f20891a55e621c6759e2c3f3891e05d63/Pygments-2.3.1.tar.gz";
        sha256 = "5ffada19f6203563680669ee7f53b64dabbeb100eb51b61996085e99c03b284a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "Sphinx" = python.mkDerivation {
      name = "Sphinx-2.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/81/e3/cb726b65039569840547895e1c81759d44e50512d038268afa8c1bf2001c/Sphinx-2.0.1.tar.gz";
        sha256 = "423280646fb37944dd3c85c58fb92a20d745793a9f6c511f59da82fa97cd404b";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Babel"
        self."Jinja2"
        self."Pygments"
        self."alabaster"
        self."docutils"
        self."imagesize"
        self."packaging"
        self."requests"
        self."snowballstemmer"
        self."sphinxcontrib-applehelp"
        self."sphinxcontrib-devhelp"
        self."sphinxcontrib-htmlhelp"
        self."sphinxcontrib-jsmath"
        self."sphinxcontrib-qthelp"
        self."sphinxcontrib-serializinghtml"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description = "Python documentation generator";
      };
    };

    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.15.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f3/c8/fa7e1a0283267bee8efa10c665d8dca27e591face7e333c789c85671b3ab/Werkzeug-0.15.2.tar.gz";
        sha256 = "0a73e8bb2ff2feecfc5d56e6f458f5b99290ef34f565ffb2665801ff7de6af7a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."termcolor"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/werkzeug/";
        license = "BSD-3-Clause";
        description = "The comprehensive WSGI web application library.";
      };
    };

    "alabaster" = python.mkDerivation {
      name = "alabaster-0.7.12";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/b4/ed8dcb0d67d5cfb7f83c4d5463a7614cb1d078ad7ae890c9143edebbf072/alabaster-0.7.12.tar.gz";
        sha256 = "a661d72d58e6ea8a57f7a86e37d86716863ee5e92788398526d58b26a4e4dc02";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://alabaster.readthedocs.io";
        license = "UNKNOWN";
        description = "A configurable sidebar-enabled Sphinx theme";
      };
    };

    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz";
        sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "atomicwrites" = python.mkDerivation {
      name = "atomicwrites-1.3.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ec/0f/cd484ac8820fed363b374af30049adc8fd13065720fd4f4c6be8a2309da7/atomicwrites-1.3.0.tar.gz";
        sha256 = "75a9445bac02d8d058d5e1fe689654ba5a6556a1dfd8ce6ec55a0ed79866cfa6";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/untitaker/python-atomicwrites";
        license = licenses.mit;
        description = "Atomic file writes.";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cc/d9/931a24cc5394f19383fbbe3e1147a0291276afa43a0dc3ed0d6cd9fda813/attrs-19.1.0.tar.gz";
        sha256 = "f0b870f674851ecbfbbbd364d6b5cbdff9dcedbc7f3f5e18a6891057f21fe399";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.6";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ce/3a/3d540b9f5ee8d92ce757eebacf167b9deedb8e30aedec69a2a072b2399bb/bcrypt-3.1.6.tar.gz";
        sha256 = "44636759d222baa62806bbceb20e96f75a015a6381690d1bc2eda91c01ec02ea";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."cffi"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/bcrypt/";
        license = licenses.asl20;
        description = "Modern password hashing for your software and your servers";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2019.3.9";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/06/b8/d1ea38513c22e8c906275d135818fee16ad8495985956a9b7e2bb21942a1/certifi-2019.3.9.tar.gz";
        sha256 = "b26104d6835d1f5e49452a26eb2ff87fe7090b89dfcaee5ea2212697e1e1d7ae";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.12.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/93/1a/ab8c62b5838722f29f3daffcc8d4bd61844aa9b5f437341cc890ceee483b/cffi-1.12.3.tar.gz";
        sha256 = "041c81822e9f84b1d9c401182e174996f0bae9991f33725d059b771744290774";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pycparser"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl3;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.6.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/07/ca/bc827c5e55918ad223d59d299fff92f3563476c3b00d0a9157d9c0217449/cryptography-2.6.1.tar.gz";
        sha256 = "26c821cbeb683facb966045e2064303029d572a87ee69ca5a1bf54bf55f93ca6";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."asn1crypto"
        self."cffi"
        self."idna"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "dbus-python" = python.mkDerivation {
      name = "dbus-python-1.2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/3f/e7/4edb582d1ffd5ac3c84188deea32e960b5c8c0fe1da56ce70224f85ce542/dbus-python-1.2.8.tar.gz";
        sha256 = "abf12bbb765e300bf8e2a1b2f32f85949eab06998dbda127952c31cb63957b6f";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.freedesktop.org/wiki/Software/DBusBindings/#python";
        license = "Expat (MIT/X11)";
        description = "Python bindings for libdbus";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz";
        sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = "public domain, Python, 2-Clause BSD, GPL 3 (see COPYING.txt)";
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "effect" = python.mkDerivation {
      name = "effect-0.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e0/48/9b8f44c0ce230cb88abf1addc3efb266c2df02a325c8bf453c7a0de0b374/effect-0.12.0.tar.gz";
        sha256 = "f43322b269b2dca0c15856f090b9167d8499bf474ec64696c80a508299d51f69";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."attrs"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/python-effect/effect/";
        license = licenses.mit;
        description = "pure effects for Python";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.8";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz";
        sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "imagesize" = python.mkDerivation {
      name = "imagesize-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/41/f5/3cf63735d54aa9974e544aa25858d8f9670ac5b4da51020bbfc6aaade741/imagesize-1.1.0.tar.gz";
        sha256 = "f3832918bc3c66617f92e35f5d70729187676313caa60c187eb0f28b8fe5e3b5";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/imagesize_py";
        license = licenses.mit;
        description = "Getting image size from png/jpeg/jpeg2000/gif file";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/1a/f27de07a8a304ad5fa817bbe383d1238ac4396da447fa11ed937039fa04b/itsdangerous-1.1.0.tar.gz";
        sha256 = "321b033d07f2a4136d3ec762eac9f16a10ccd60f53c0c91af90217ace7ba1f19";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/itsdangerous/";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass data to untrusted environments and back.";
      };
    };

    "jinja2-cli" = python.mkDerivation {
      name = "jinja2-cli-0.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/50/24/a774867a93c19d21f132154b509ad014ab22106e1927d0241b556cf8c836/jinja2-cli-0.6.0.tar.gz";
        sha256 = "4b1be17ce8a8f133df02205c3f0d3ebfc3a68e795d26987f846a2316636427b7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Jinja2"
        self."PyYAML"
        self."toml"
        self."xmltodict"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mattrobenolt/jinja2-cli";
        license = licenses.bsdOriginal;
        description = "A CLI interface to Jinja2";
      };
    };

    "kubecert" = python.mkDerivation {
      name = "kubecert-1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/kubecert";
        sha256 = "1yjvck75c2hdbwyz6l4xgbcngbn1h7j06lmhbgmx8qhkv9lkbwy3";
        rev = "7e65d5707a0136f63834fe16cf52e4819ec14067";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."effect"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = "UNKNOWN";
        description = "UNKNOWN";
      };
    };

    "lxml" = python.mkDerivation {
      name = "lxml-4.3.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/7d/29/174d70f303016c58bd790c6c86e6e86a9d18239fac314d55a9b7be501943/lxml-4.3.3.tar.gz";
        sha256 = "4a03dd682f8e35a10234904e0b9508d705ff98cf962c5851ed052e9340df3d90";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-7.0.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/29/ed/3a85eb4afdce6dc33e78dad885e17c678db8055bf65353e0de4944c72a40/more-itertools-7.0.0.tar.gz";
        sha256 = "c3e4748ba1aad8dba30a4886b0b1a2004f9a863837b8654e7059eebf727afa5a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "nix-helpers" = python.mkDerivation {
      name = "nix-helpers-1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/nix-helpers";
        sha256 = "18wnwlz1hv87ldc849sjiz86c19abcxq2h758yc4f3p02zqp69y9";
        rev = "8e8a988acba86fd5184e0a429720918a4fe2704a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Click"
        self."Jinja2"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seppeljordan/nix-helpers";
        license = "GPL-3";
        description = "Utilities for working with Nix package manager";
      };
    };

    "nix-prefetch-github" = python.mkDerivation {
      name = "nix-prefetch-github-2.2";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/nix-prefetch-github";
        sha256 = "1m1d1fzacvwprfvhxih1hzr1m0y1jjxiznf8p8b3bi5a41yzvrrl";
        rev = "9ce3bcc3610ffeb36f53bc690682f48c8d311764";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Click"
        self."Jinja2"
        self."attrs"
        self."effect"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seppeljordan/nix-prefetch-github";
        license = "GPL3";
        description = "Prefetch source code from github for nix build tool";
      };
    };

    "nix-pureos" = python.mkDerivation {
      name = "nix-pureos-1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/nix-pureos";
        sha256 = "12jx00syi4dzjlk0hqq6hb0ba7rvijr2dwd7m4w21q4v0f1sh34i";
        rev = "46d7987231ac1ef7a110b2f8881aab25d4c2c128";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Click"
        self."pydbus"
        self."xdg"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = "GPLv3";
        description = "Manage user services and files with nix on pureOS";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-19.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/16/51/d72654dbbaa4a4ffbf7cb0ecd7d12222979e0a660bf3f42acc47550bf098/packaging-19.0.tar.gz";
        sha256 = "0c98a5d0be38ed775798ece1b9727178c4469d9c3b4ada66e8e6b7849f8732af";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pyparsing"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/packaging";
        license = licenses.bsdOriginal;
        description = "Core utilities for Python packages";
      };
    };

    "paramiko" = python.mkDerivation {
      name = "paramiko-2.4.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a4/57/86681372e7a8d642718cadeef38ead1c24c4a1af21ae852642bf974e37c7/paramiko-2.4.2.tar.gz";
        sha256 = "a8975a7df3560c9f1e2b43dc54ebd40fd00a7017392ca5445ce7df409f900fcb";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."PyNaCl"
        self."bcrypt"
        self."cryptography"
        self."pyasn1"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/paramiko/paramiko/";
        license = licenses.lgpl3;
        description = "SSH2 protocol library";
      };
    };

    "parsemon2" = python.mkDerivation {
      name = "parsemon2-3.0";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/parsemon2";
        sha256 = "054aivp23m2da9pf3lj2x0qa3kmvkhpraziz8dics8ijr5bjm6nc";
        rev = "71ff099a2acd8f07b2afd5fe4ddcbc24942d377b";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."attrs"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = "GPLv3";
        description = "A monadic parser combinator written purely in python";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.9.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/a7/8c/55c629849c64e665258d8976322dfdad171fa2f57117590662d8a67618a4/pluggy-0.9.0.tar.gz";
        sha256 = "19ecf9ce9db2fce065a7a0586e07cfb4ac8614fe96edf628a264b1c70116cf8f";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = "MIT license";
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.8.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f1/5a/87ca5909f400a2de1561f1648883af74345fe96349f34f737cdfc94eba8c/py-1.8.0.tar.gz";
        sha256 = "dc639b046a6e2cff5bbe40194ad65936d6ba360b52b3c3fe1d08a82dd50b5e53";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [
        self."setuptools-scm"
      ];
      buildInputs = commonBuildInputs ++ [
        self."setuptools-scm"
      ];
      nativeBuildInputs = commonBuildInputs ++ [
        self."setuptools-scm"
      ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [
        self."setuptools-scm"
      ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = "MIT license";
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.5";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/46/60/b7e32f6ff481b8a1f6c8f02b0fd9b693d1c92ddd2efb038ec050d99a7245/pyasn1-0.4.5.tar.gz";
        sha256 = "da2420fe13a9452d8ae97a0e478adde1dee153b11ba832a95b223a2ba01c10f7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pycairo" = python.mkDerivation {
      name = "pycairo-1.18.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/48/20/5e83af98eb897935bf7dc39455e892ba866feebb9b7c3b392982866f9958/pycairo-1.18.1.tar.gz";
        sha256 = "70172e58b6bad7572a3518c26729b074acdde15e6fee6cbab6d3528ad552b786";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycairo.readthedocs.io";
        license = "UNKNOWN";
        description = "Python interface for cairo";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz";
        sha256 = "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pydbus" = python.mkDerivation {
      name = "pydbus-0.6.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/58/56/3e84f2c1f2e39b9ea132460183f123af41e3b9c8befe222a35636baa6a5a/pydbus-0.6.0.tar.gz";
        sha256 = "4207162eff54223822c185da06c1ba8a34137a9602f3da5a528eedf3f78d0f2c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/LEW21/pydbus";
        license = "LGPLv2+";
        description = "Pythonic DBus library";
      };
    };

    "pykube" = python.mkDerivation {
      name = "pykube-0.16a1";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/pykube";
        sha256 = "0cfp83n9y8jfwzbz1pdgshrqzg7m27j3aqzz3xaphbl1k9lrsabj";
        rev = "e8a46298a592ad9037587afb707ac75b3114eff9";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."PyYAML"
        self."requests"
        self."six"
        self."tzlocal"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kelproject/pykube";
        license = "Apache";
        description = "Python client library for Kubernetes";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/5d/3a/24d275393f493004aeb15a1beae2b4a3043526e8b692b65b4a9341450ebe/pyparsing-2.4.0.tar.gz";
        sha256 = "1873c03321fc118f4e9746baf201ff990ceb915f433f23b395f5580d1840cb2a";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pypi2nix" = python.mkDerivation {
      name = "pypi2nix-2.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/garbas/pypi2nix";
        sha256 = "0l4ywjn0lb53519m2155r6sfcrlkpx6pnha54kmsqd45pv6lz0rv";
        rev = "ff1ba9006839fd46e4b237d2757be5b22d408565";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Click"
        self."Jinja2"
        self."nix-prefetch-github"
        self."requests"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/NixOS/pypi2nix";
        license = licenses.bsdOriginal;
        description = "A tool that generates nix expressions for your python packages, so you don't have to.";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-4.4.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/2b/b1/c9a84f79fc3bad226a9085289da11ecdd9bd2779a2c654195962b37d4110/pytest-4.4.1.tar.gz";
        sha256 = "b7802283b70ca24d7119b32915efa7c409982f59913c1a6c0640aacf118b95f5";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."atomicwrites"
        self."attrs"
        self."more-itertools"
        self."pluggy"
        self."py"
        self."requests"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pytest.org/en/latest/";
        license = "MIT license";
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/df/d5/3e3ff673e8f3096921b3f1b79ce04b832e0100b4741573154b72b756a681/pytz-2019.1.tar.gz";
        sha256 = "d747dd3d23d77ef44c6a3526e274af6efeb0a6f1afd5a69ba4d5be4098c8e141";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.21.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/52/2c/514e4ac25da2b08ca5a464c50463682126385c4272c18193876e91f4bc38/requests-2.21.0.tar.gz";
        sha256 = "502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."chardet"
        self."cryptography"
        self."idna"
        self."urllib3"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://python-requests.org";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.2.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/54/85/514ba3ca2a022bddd68819f187ae826986051d130ec5b972076e4f58a9f3/setuptools_scm-3.2.0.tar.gz";
        sha256 = "52ab47715fa0fc7d8e6cd15168d1a69ba995feb1505131c3e814eb7087b57358";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.12.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz";
        sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "snowballstemmer" = python.mkDerivation {
      name = "snowballstemmer-1.2.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/20/6b/d2a7cb176d4d664d94a6debf52cd8dbae1f7203c8e42426daa077051d59c/snowballstemmer-1.2.1.tar.gz";
        sha256 = "919f26a68b2c17a7634da993d91339e288964f93c274f1343e3bbbe2096e1128";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/snowball_py";
        license = licenses.bsdOriginal;
        description = "This package provides 16 stemmer algorithms (15 + Poerter English stemmer) generated from Snowball algorithms.";
      };
    };

    "sphinxcontrib-applehelp" = python.mkDerivation {
      name = "sphinxcontrib-applehelp-1.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1b/71/8bafa145e48131049dd4f731d6f6eeefe0c34c3017392adbec70171ad407/sphinxcontrib-applehelp-1.0.1.tar.gz";
        sha256 = "edaa0ab2b2bc74403149cb0209d6775c96de797dfd5b5e2a71981309efab3897";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "sphinxcontrib-devhelp" = python.mkDerivation {
      name = "sphinxcontrib-devhelp-1.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/57/5f/bf9a0f7454df68a7a29033a5cf8d53d0797ae2e426b1b419e4622726ec7d/sphinxcontrib-devhelp-1.0.1.tar.gz";
        sha256 = "6c64b077937330a9128a4da74586e8c2130262f014689b4b89e2d08ee7294a34";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "sphinxcontrib-htmlhelp" = python.mkDerivation {
      name = "sphinxcontrib-htmlhelp-1.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/f1/f2/88e9d6dc4a17f1e95871f8b634adefcc5d691334f7a121e9f384d1dc06fd/sphinxcontrib-htmlhelp-1.0.2.tar.gz";
        sha256 = "4670f99f8951bd78cd4ad2ab962f798f5618b17675c35c5ac3b2132a14ea8422";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "sphinxcontrib-jsmath" = python.mkDerivation {
      name = "sphinxcontrib-jsmath-1.0.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b2/e8/9ed3830aeed71f17c026a07a5097edcf44b692850ef215b161b8ad875729/sphinxcontrib-jsmath-1.0.1.tar.gz";
        sha256 = "a9925e4a4587247ed2191a22df5f6970656cb8ca2bd6284309578f2153e0c4b8";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description = "A sphinx extension which renders display math in HTML via JavaScript";
      };
    };

    "sphinxcontrib-qthelp" = python.mkDerivation {
      name = "sphinxcontrib-qthelp-1.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0c/f0/690cd10603e3ea8d184b2fffde1d965dd337b87a1d5f7625d0f6791094f4/sphinxcontrib-qthelp-1.0.2.tar.gz";
        sha256 = "79465ce11ae5694ff165becda529a600c754f4bc459778778c7017374d4d406f";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "sphinxcontrib-serializinghtml" = python.mkDerivation {
      name = "sphinxcontrib-serializinghtml-1.1.3";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cd/cc/fd7d17cfae18e5a92564bb899bc05e13260d7a633f3cffdaad4e5f3ce46a/sphinxcontrib-serializinghtml-1.1.3.tar.gz";
        sha256 = "c0efb33f8052c04fd7a26c0a07f1678e8512e0faec19f4aa8f2473a8b81d5227";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "stormssh" = python.mkDerivation {
      name = "stormssh-0.7.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/0a/18/85d12be676ae0c1d98173b07cc289bbf9e0c67d6c7054b8df3e1003bf992/stormssh-0.7.0.tar.gz";
        sha256 = "8d034dcd9487fa0d280e0ec855d08420f51d5f9f2249f932e3c12119eaa53453";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."Flask"
        self."paramiko"
        self."six"
        self."termcolor"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/emre/storm";
        license = licenses.mit;
        description = "Management commands to ssh config files.";
      };
    };

    "termcolor" = python.mkDerivation {
      name = "termcolor-1.1.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz";
        sha256 = "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/termcolor";
        license = licenses.mit;
        description = "ANSII Color formatting for output in terminal.";
      };
    };

    "toml" = python.mkDerivation {
      name = "toml-0.10.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b9/19/5cbd78eac8b1783671c40e34bb0fa83133a06d340a38b55c645076d40094/toml-0.10.0.tar.gz";
        sha256 = "229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = licenses.mit;
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "tzlocal" = python.mkDerivation {
      name = "tzlocal-1.5.1";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/cb/89/e3687d3ed99bc882793f82634e9824e62499fdfdc4b1ae39e211c5b05017/tzlocal-1.5.1.tar.gz";
        sha256 = "4ebeb848845ac898da6519b9b31879cf13b6626f7184c496037b818e238f2c4e";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."pytz"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/regebro/tzlocal";
        license = licenses.mit;
        description = "tzinfo object for the local timezone";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.24.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/fd/fa/b21f4f03176463a6cccdb612a5ff71b927e5224e83483012747c12fc5d62/urllib3-1.24.2.tar.gz";
        sha256 = "9a247273df709c4fedb38c711e44292304f73f39ab01beda9f6b9fc375669ac3";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."certifi"
        self."cryptography"
        self."idna"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "xdg" = python.mkDerivation {
      name = "xdg-3.0.2";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/1a/14/5bb008f64444c5257fce77adc9356c89cdf9bf674e423af41d4287f00cde/xdg-3.0.2.tar.gz";
        sha256 = "7ce9fc52cee0f8e31d0beb0f29e102f23725c0c470aee447d907e1999ffda7b7";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/srstevenson/xdg";
        license = "ISC";
        description = "Variables defined by the XDG Base Directory Specification";
      };
    };

    "xmltodict" = python.mkDerivation {
      name = "xmltodict-0.11.0";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/57/17/a6acddc5f5993ea6eaf792b2e6c3be55e3e11f3b85206c818572585f61e1/xmltodict-0.11.0.tar.gz";
        sha256 = "8f8d7d40aa28d83f4109a7e8aa86e67a4df202d9538be40c0cb1d70da527b0df";
      };
      doCheck = commonDoCheck;
      checkInputs = commonBuildInputs ++ [ ];
      buildInputs = commonBuildInputs ++ [ ];
      nativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedNativeBuildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/martinblech/xmltodict";
        license = licenses.mit;
        description = "Makes working with XML feel like you are working with JSON";
      };
    };
  };
  localOverridesFile = ./python3_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (let src = pkgs.fetchFromGitHub { owner = "garbas"; repo = "nixpkgs-python"; rev = "403bb1d312b1cfd82663208d7e9ae48c8ff2614a"; sha256 = "0v4gxikwh4362s40an68kj7dyiib1bcq5bn9m5j7h93yniz3zkd3"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  paramOverrides = [
    (overrides { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [localOverrides] else [] ) ++ commonOverrides ++ paramOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )