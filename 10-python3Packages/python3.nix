# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3 -v -E libffi openssl mercurial libxml2 libxslt pkgconfig dbus dbus-glib ncurses cairo gobjectIntrospection --setup-requires pycairo -r python3.txt --default-overrides --basename python3
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/be/cc/9c981b249a455fa0c76338966325fc70b7265521bad641bf2932f77712f4/Babel-2.6.0.tar.gz"; sha256 = "8cba50f48c529ca3fa18cf81fa9403be176d374ac4d60738b839122dfaaa3d23"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz"; sha256 = "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/click/";
        license = licenses.bsdOriginal;
        description = "Composable command line interface toolkit";
      };
    };

    "Flask" = python.mkDerivation {
      name = "Flask-1.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4b/12/c1fbf4971fda0e4de05565694c9f0c92646223cff53f15b6eb248a310a62/Flask-1.0.2.tar.gz"; sha256 = "2271c0070dbcb5275fad4a82e29f23ab92682dc45f9dfbc22c02ba9b9322ce48"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Click"
      self."Jinja2"
      self."Sphinx"
      self."Werkzeug"
      self."itsdangerous"
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.com/p/flask/";
        license = licenses.bsdOriginal;
        description = "A simple framework for building complex web applications.";
      };
    };

    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"; sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      name = "MarkupSafe-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ac/7e/1b4c2e05809a4414ebce0892fe1e32c14ace86ca7d50c70f00979ca9b3a3/MarkupSafe-1.1.0.tar.gz"; sha256 = "4e97332c9ce444b0c2c38dd22ddc61c743eb208d916e4265a2a3b575bdccb1d3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.com/p/markupsafe/";
        license = licenses.bsdOriginal;
        description = "Safely add untrusted strings to HTML/XML markup.";
      };
    };

    "PyGObject" = python.mkDerivation {
      name = "PyGObject-3.30.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8c/1f/76533985b054473ef6ab1ba4d9c00d62da502f8b43d3171ae588ec81ae93/PyGObject-3.30.4.tar.gz"; sha256 = "2d4423cbf169d50a3165f2dde21478a00215c7fb3f68d9d236af588c670980bb"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pycairo"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pygobject.readthedocs.io";
        license = licenses.lgpl2Plus;
        description = "Python bindings for GObject Introspection";
      };
    };

    "PyNaCl" = python.mkDerivation {
      name = "PyNaCl-1.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/61/ab/2ac6dea8489fa713e2b4c6c5b549cc962dd4a842b5998d9e80cf8440b7cd/PyNaCl-1.3.0.tar.gz"; sha256 = "0c6100edd16fefd1557da078c7a31e7b7d7a52ce39fdca2bec29d4f7b6e7600c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Sphinx"
      self."cffi"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/pynacl/";
        license = licenses.asl20;
        description = "Python binding to the Networking and Cryptography (NaCl) library";
      };
    };

    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.13";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9e/a3/1d13970c3f36777c583f136c136f804d70f500168edc1edea6daa7200769/PyYAML-3.13.tar.gz"; sha256 = "3ef3092145e9b70e3ddd2c7ad59bdd0252a94dfe3949721633e41344de00a6bf"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "Pygments" = python.mkDerivation {
      name = "Pygments-2.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/64/69/413708eaf3a64a6abb8972644e0f20891a55e621c6759e2c3f3891e05d63/Pygments-2.3.1.tar.gz"; sha256 = "5ffada19f6203563680669ee7f53b64dabbeb100eb51b61996085e99c03b284a"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "Sphinx" = python.mkDerivation {
      name = "Sphinx-1.8.3";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/ed/4595274b5c9ce53a768cc0804ef65fd6282c956b93919a969e98d53894e4/Sphinx-1.8.3.tar.gz"; sha256 = "c4cb17ba44acffae3d3209646b6baec1e215cad3065e852c68cc569d4df1b9f8"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Babel"
      self."Jinja2"
      self."Pygments"
      self."alabaster"
      self."docutils"
      self."imagesize"
      self."packaging"
      self."pytest"
      self."requests"
      self."six"
      self."snowballstemmer"
      self."sphinxcontrib-websupport"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description = "Python documentation generator";
      };
    };

    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.14.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9f/08/a3bb1c045ec602dc680906fc0261c267bed6b3bb4609430aff92c3888ec8/Werkzeug-0.14.1.tar.gz"; sha256 = "c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Sphinx"
      self."pytest"
      self."termcolor"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.org/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
      };
    };

    "alabaster" = python.mkDerivation {
      name = "alabaster-0.7.12";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cc/b4/ed8dcb0d67d5cfb7f83c4d5463a7614cb1d078ad7ae890c9143edebbf072/alabaster-0.7.12.tar.gz"; sha256 = "a661d72d58e6ea8a57f7a86e37d86716863ee5e92788398526d58b26a4e4dc02"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://alabaster.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "A configurable sidebar-enabled Sphinx theme";
      };
    };

    "asn1crypto" = python.mkDerivation {
      name = "asn1crypto-0.24.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz"; sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "atomicwrites" = python.mkDerivation {
      name = "atomicwrites-1.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ac/ed/a311712ef6b4355035489f665e63e1a73f9eb371929e3c98e5efd451069e/atomicwrites-1.2.1.tar.gz"; sha256 = "ec9ae8adaae229e4f8446952d204a3e4b5fdd2d099f9be3aaf556120135fb3ee"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/untitaker/python-atomicwrites";
        license = licenses.mit;
        description = "Atomic file writes.";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-18.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0f/9e/26b1d194aab960063b266170e53c39f73ea0d0d3f5ce23313e0ec8ee9bdf/attrs-18.2.0.tar.gz"; sha256 = "10cbf6e27dbce8c30807caf056c8eb50917e0eaafe86347671b57254006c3e69"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Sphinx"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.6";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ce/3a/3d540b9f5ee8d92ce757eebacf167b9deedb8e30aedec69a2a072b2399bb/bcrypt-3.1.6.tar.gz"; sha256 = "44636759d222baa62806bbceb20e96f75a015a6381690d1bc2eda91c01ec02ea"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."cffi"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/bcrypt/";
        license = licenses.asl20;
        description = "Modern password hashing for your software and your servers";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2018.11.29";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/55/54/3ce77783acba5979ce16674fc98b1920d00b01d337cfaaf5db22543505ed/certifi-2018.11.29.tar.gz"; sha256 = "47f9c83ef4c0c621eaef743f133f09fa8a74a9b75f037e8624f83bd1b6626cb7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.11.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"; sha256 = "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/69/ed/5e97b7f54237a9e4e6291b6e52173372b7fa45ca730d36ea90b790c0059a/cryptography-2.5.tar.gz"; sha256 = "4946b67235b9d2ea7d31307be9d5ad5959d6c4a8f98f900157b47abddf698401"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Sphinx"
      self."asn1crypto"
      self."cffi"
      self."idna"
      self."pytest"
      self."pytz"
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/3f/e7/4edb582d1ffd5ac3c84188deea32e960b5c8c0fe1da56ce70224f85ce542/dbus-python-1.2.8.tar.gz"; sha256 = "abf12bbb765e300bf8e2a1b2f32f85949eab06998dbda127952c31cb63957b6f"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.freedesktop.org/wiki/Software/DBusBindings/#python";
        license = licenses.mit;
        description = "Python bindings for libdbus";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "effect" = python.mkDerivation {
      name = "effect-0.12.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e0/48/9b8f44c0ce230cb88abf1addc3efb266c2df02a325c8bf453c7a0de0b374/effect-0.12.0.tar.gz"; sha256 = "f43322b269b2dca0c15856f090b9167d8499bf474ec64696c80a508299d51f69"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ad/13/eb56951b6f7950cadb579ca166e448ba77f9d24efc03edd7e55fa57d04b7/idna-2.8.tar.gz"; sha256 = "c357b3f628cf53ae2c4c05627ecc484553142ca23264e593d327bcde5e9c3407"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "imagesize" = python.mkDerivation {
      name = "imagesize-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/41/f5/3cf63735d54aa9974e544aa25858d8f9670ac5b4da51020bbfc6aaade741/imagesize-1.1.0.tar.gz"; sha256 = "f3832918bc3c66617f92e35f5d70729187676313caa60c187eb0f28b8fe5e3b5"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/imagesize_py";
        license = licenses.mit;
        description = "Getting image size from png/jpeg/jpeg2000/gif file";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/68/1a/f27de07a8a304ad5fa817bbe383d1238ac4396da447fa11ed937039fa04b/itsdangerous-1.1.0.tar.gz"; sha256 = "321b033d07f2a4136d3ec762eac9f16a10ccd60f53c0c91af90217ace7ba1f19"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/itsdangerous/";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass data to untrusted environments and back.";
      };
    };

    "jinja2-cli" = python.mkDerivation {
      name = "jinja2-cli-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/50/24/a774867a93c19d21f132154b509ad014ab22106e1927d0241b556cf8c836/jinja2-cli-0.6.0.tar.gz"; sha256 = "4b1be17ce8a8f133df02205c3f0d3ebfc3a68e795d26987f846a2316636427b7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."PyYAML"
      self."pytest"
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
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/kubecert"; sha256 = "1vpdcjasysz17dfr1ini9jw25cmhm2x1yh7rd9z9xk5ql1y5s1w7"; rev = "e9e089c71f970fba72cb495cd433549687a180cf"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."effect"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "UNKNOWN";
      };
    };

    "lxml" = python.mkDerivation {
      name = "lxml-4.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/4a/b085a04d6dad79aa5c00c65c9b2bbcb2c6c22e5ac341e7968e0ad2c57e2f/lxml-4.3.0.tar.gz"; sha256 = "d1e111b3ab98613115a208c1017f266478b0ab224a67bc8eac670fa0bad7d488"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://lxml.de/";
        license = licenses.bsdOriginal;
        description = "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-5.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/dd/26/30fc0d541d9fdf55faf5ba4b0fd68f81d5bd2447579224820ad525934178/more-itertools-5.0.0.tar.gz"; sha256 = "38a936c0a6d98a38bcc2d03fdaaedaba9f412879461dd2ceff8d37564d6522e4"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };

    "nix-helpers" = python.mkDerivation {
      name = "nix-helpers-1.0";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/nix-helpers"; sha256 = "18wnwlz1hv87ldc849sjiz86c19abcxq2h758yc4f3p02zqp69y9"; rev = "8e8a988acba86fd5184e0a429720918a4fe2704a"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      name = "nix-prefetch-github-1.3";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/nix-prefetch-github"; sha256 = "1vf5i3s9ql9cr37smbqyqdrpiympjxx3kmwn6xv9h2fn5jyiwh8y"; rev = "f71616bde96da27329e4a6db4a339381472f2e36"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/nix-pureos"; sha256 = "12jx00syi4dzjlk0hqq6hb0ba7rvijr2dwd7m4w21q4v0f1sh34i"; rev = "46d7987231ac1ef7a110b2f8881aab25d4c2c128"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Click"
      self."pydbus"
      self."xdg"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "GPLv3";
        description = "Manage user services and files with nix on pureOS";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-19.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/51/d72654dbbaa4a4ffbf7cb0ecd7d12222979e0a660bf3f42acc47550bf098/packaging-19.0.tar.gz"; sha256 = "0c98a5d0be38ed775798ece1b9727178c4469d9c3b4ada66e8e6b7849f8732af"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a4/57/86681372e7a8d642718cadeef38ead1c24c4a1af21ae852642bf974e37c7/paramiko-2.4.2.tar.gz"; sha256 = "a8975a7df3560c9f1e2b43dc54ebd40fd00a7017392ca5445ce7df409f900fcb"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyNaCl"
      self."bcrypt"
      self."cryptography"
      self."pyasn1"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/paramiko/paramiko/";
        license = licenses.lgpl2;
        description = "SSH2 protocol library";
      };
    };

    "parsemon2" = python.mkDerivation {
      name = "parsemon2-2.2";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/parsemon2"; sha256 = "1h9gzjhzif3xdkgfxpa87q5lzryd93zal83ryqibyf2vhk84ykn5"; rev = "91df55eb5c0a3d12d6044713429ebdc4e7ce5f6f"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl3;
        description = "A monadic parser combinator written purely in python";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.8.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/38/e1/83b10c17688af7b2998fa5342fec58ecbd2a5a7499f31e606ae6640b71ac/pluggy-0.8.1.tar.gz"; sha256 = "8ddc32f03971bfdf900a81961a48ccf2fb677cf7715108f85295c67405798616"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.7.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c7/fa/eb6dd513d9eb13436e110aaeef9a1703437a8efa466ce6bb2ff1d9217ac7/py-1.7.0.tar.gz"; sha256 = "bf92637198836372b520efcba9e020c330123be8ce527e535d185ed4b6f45694"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/46/60/b7e32f6ff481b8a1f6c8f02b0fd9b693d1c92ddd2efb038ec050d99a7245/pyasn1-0.4.5.tar.gz"; sha256 = "da2420fe13a9452d8ae97a0e478adde1dee153b11ba832a95b223a2ba01c10f7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pycairo" = python.mkDerivation {
      name = "pycairo-1.18.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/a6/54/23d6cf3e8d8f1eb30e0e58f171b6f62b2ea75c024935492373639a1a08e4/pycairo-1.18.0.tar.gz"; sha256 = "abd42a4c9c2069febb4c38fe74bfc4b4a9d3a89fea3bc2e4ba7baff7a20f783f"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://pycairo.readthedocs.io";
        license = licenses.lgpl2;
        description = "Python interface for cairo";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz"; sha256 = "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pydbus" = python.mkDerivation {
      name = "pydbus-0.6.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/58/56/3e84f2c1f2e39b9ea132460183f123af41e3b9c8befe222a35636baa6a5a/pydbus-0.6.0.tar.gz"; sha256 = "4207162eff54223822c185da06c1ba8a34137a9602f3da5a528eedf3f78d0f2c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/LEW21/pydbus";
        license = licenses.lgpl2Plus;
        description = "Pythonic DBus library";
      };
    };

    "pykube" = python.mkDerivation {
      name = "pykube-0.16a1";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/pykube"; sha256 = "0cfp83n9y8jfwzbz1pdgshrqzg7m27j3aqzz3xaphbl1k9lrsabj"; rev = "e8a46298a592ad9037587afb707ac75b3114eff9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."requests"
      self."six"
      self."tzlocal"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kelproject/pykube";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Python client library for Kubernetes";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.3.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b9/b8/6b32b3e84014148dcd60dd05795e35c2e7f4b72f918616c61fdce83d27fc/pyparsing-2.3.1.tar.gz"; sha256 = "66c9268862641abcac4a96ba74506e594c884e3f57690a696d21ad8210ed667a"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pypi2nix" = python.mkDerivation {
      name = "pypi2nix-2.0.0";
      src = pkgs.fetchgit { url = "https://github.com/garbas/pypi2nix"; sha256 = "0nrz4863infjwipn3lgac42f4y3ld7045ls2q9z4z4x50xk7p4zm"; rev = "0498dac1c6c5ee445ed23056af0efb3e2358358d"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      name = "pytest-4.1.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e2/1d/5aaae6a77d9699ebcc5cbed574c28272371b8915073a126a9ead961c8f6c/pytest-4.1.1.tar.gz"; sha256 = "c3c573a29d7c9547fb90217ece8a8843aa0c1328a797e200290dc3d0b4b823be"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2018.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/af/be/6c59e30e208a5f28da85751b93ec7b97e4612268bb054d0dff396e758a90/pytz-2018.9.tar.gz"; sha256 = "d5f05e487007e29e03409f9398d074e158d920d36eb82eaf66fb1136b0c5374c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.21.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/52/2c/514e4ac25da2b08ca5a464c50463682126385c4272c18193876e91f4bc38/requests-2.21.0.tar.gz"; sha256 = "502a824f31acdacb3a35b6690b5fbf0bc41d63a24a45c4004352b0242707598e"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/54/85/514ba3ca2a022bddd68819f187ae826986051d130ec5b972076e4f58a9f3/setuptools_scm-3.2.0.tar.gz"; sha256 = "52ab47715fa0fc7d8e6cd15168d1a69ba995feb1505131c3e814eb7087b57358"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.12.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/dd/bf/4138e7bfb757de47d1f4b6994648ec67a51efe58fa907c1e11e350cddfca/six-1.12.0.tar.gz"; sha256 = "d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "snowballstemmer" = python.mkDerivation {
      name = "snowballstemmer-1.2.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/20/6b/d2a7cb176d4d664d94a6debf52cd8dbae1f7203c8e42426daa077051d59c/snowballstemmer-1.2.1.tar.gz"; sha256 = "919f26a68b2c17a7634da993d91339e288964f93c274f1343e3bbbe2096e1128"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/snowball_py";
        license = licenses.bsdOriginal;
        description = "This package provides 16 stemmer algorithms (15 + Poerter English stemmer) generated from Snowball algorithms.";
      };
    };

    "sphinxcontrib-websupport" = python.mkDerivation {
      name = "sphinxcontrib-websupport-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/07/7a/e74b06dce85555ffee33e1d6b7381314169ebf7e31b62c18fcb2815626b7/sphinxcontrib-websupport-1.1.0.tar.gz"; sha256 = "9de47f375baf1ea07cdb3436ff39d7a9c76042c10a769c52353ec46e4e8fc3b9"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description = "Sphinx API for Web Apps";
      };
    };

    "stormssh" = python.mkDerivation {
      name = "stormssh-0.7.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/0a/18/85d12be676ae0c1d98173b07cc289bbf9e0c67d6c7054b8df3e1003bf992/stormssh-0.7.0.tar.gz"; sha256 = "8d034dcd9487fa0d280e0ec855d08420f51d5f9f2249f932e3c12119eaa53453"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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

    "svm-kubernetes-utils" = python.mkDerivation {
      name = "svm-kubernetes-utils-0.1";
      src = pkgs.fetchhg { url = "https://bitbucket.org/schneevonmorgen/kubernetes-utils"; sha256 = "0ihrwwzx3cwzq0qrh9dhyardy1900hzpms25b7qpb2b1cglyilfq"; rev = "bf79593451ff"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pykube"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/schneevonmorgen/kubernetes-utils";
        license = "";
        description = "Utility for applications running on kubernetes";
      };
    };

    "termcolor" = python.mkDerivation {
      name = "termcolor-1.1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz"; sha256 = "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/termcolor";
        license = licenses.mit;
        description = "ANSII Color formatting for output in terminal.";
      };
    };

    "toml" = python.mkDerivation {
      name = "toml-0.10.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b9/19/5cbd78eac8b1783671c40e34bb0fa83133a06d340a38b55c645076d40094/toml-0.10.0.tar.gz"; sha256 = "229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = licenses.mit;
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "tzlocal" = python.mkDerivation {
      name = "tzlocal-1.5.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cb/89/e3687d3ed99bc882793f82634e9824e62499fdfdc4b1ae39e211c5b05017/tzlocal-1.5.1.tar.gz"; sha256 = "4ebeb848845ac898da6519b9b31879cf13b6626f7184c496037b818e238f2c4e"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      name = "urllib3-1.24.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b1/53/37d82ab391393565f2f831b8eedbffd57db5a718216f82f1a8b4d381a1c1/urllib3-1.24.1.tar.gz"; sha256 = "de9529817c93f27c8ccbfead6985011db27bd0ddfcdb2d86f3f663385c6a9c22"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1a/14/5bb008f64444c5257fce77adc9356c89cdf9bf674e423af41d4287f00cde/xdg-3.0.2.tar.gz"; sha256 = "7ce9fc52cee0f8e31d0beb0f29e102f23725c0c470aee447d907e1999ffda7b7"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/srstevenson/xdg";
        license = licenses.isc;
        description = "Variables defined by the XDG Base Directory Specification";
      };
    };

    "xmltodict" = python.mkDerivation {
      name = "xmltodict-0.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/57/17/a6acddc5f5993ea6eaf792b2e6c3be55e3e11f3b85206c818572585f61e1/xmltodict-0.11.0.tar.gz"; sha256 = "8f8d7d40aa28d83f4109a7e8aa86e67a4df202d9538be40c0cb1d70da527b0df"; };
      doCheck = commonDoCheck;
      checkPhase = "";
      installCheckPhase = "";
      buildInputs = commonBuildInputs;
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