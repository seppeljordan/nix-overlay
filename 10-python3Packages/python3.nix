# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -vvv -V 3 -E libffi openssl mercurial -r 10-python3Packages/python3.txt --default-overrides -O ./python3_override.nix --basename 10-python3Packages/python3
#

{ pkgs ? import <nixpkgs> {}
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
            sed -i \
              -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
              -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = with pkgs; [ libffi openssl mercurial ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (builtins.attrValues pkgs)}; do
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
    in {
      __old = pythonPackages;
      inherit interpreter;
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
      name = "Babel-2.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0e/d5/9b1d6a79c975d0e9a32bd337a1465518c2519b14b214682ca9892752417e/Babel-2.5.3.tar.gz"; sha256 = "8ce4cb6fdd4393edd323227cba3a077bceb2a6ce5201c902c65e730046f41f14"; };
      doCheck = commonDoCheck;
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

    "Flask" = python.mkDerivation {
      name = "Flask-0.12.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/eb/12/1c7bd06fcbd08ba544f25bf2c6612e305a70ea51ca0eda8007344ec3f123/Flask-0.12.2.tar.gz"; sha256 = "49f44461237b69ecd901cc7ce66feea0319b9158743dd27a2899962ab214dac1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."Werkzeug"
      self."click"
      self."itsdangerous"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/flask/";
        license = licenses.bsdOriginal;
        description = "A microframework based on Werkzeug, Jinja2 and good intentions";
      };
    };

    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"; sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"; };
      doCheck = commonDoCheck;
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
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };

    "PyNaCl" = python.mkDerivation {
      name = "PyNaCl-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/08/19/cf56e60efd122fa6d2228118a9b345455b13ffe16a14be81d025b03b261f/PyNaCl-1.2.1.tar.gz"; sha256 = "e0d38fa0a75f65f556fb912f2c6790d1fa29b7dd27a1d9cc5591b281321eaaa9"; };
      doCheck = commonDoCheck;
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
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "Pygments" = python.mkDerivation {
      name = "Pygments-2.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"; sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "Sphinx" = python.mkDerivation {
      name = "Sphinx-1.7.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/0d/12/843cdf08c9795d1d225c92e099a18143856110cbeff562b8abd60bd26cec/Sphinx-1.7.2.tar.gz"; sha256 = "5a1c9a0fec678c24b9a2f5afba240c04668edb7f45c67ce2ed008996b3f21ae2"; };
      doCheck = commonDoCheck;
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
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9f/08/a3bb1c045ec602dc680906fc0261c267bed6b3bb4609430aff92c3888ec8/Werkzeug-0.14.1.tar.gz"; sha256 = "c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"; };
      doCheck = commonDoCheck;
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
      name = "alabaster-0.7.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d0/a5/e3a9ad3ee86aceeff71908ae562580643b955ea1b1d4f08ed6f7e8396bd7/alabaster-0.7.10.tar.gz"; sha256 = "37cdcb9e9954ed60912ebc1ca12a9d12178c26637abdf124e3cde2341c257fe0"; };
      doCheck = commonDoCheck;
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
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz"; sha256 = "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/wbond/asn1crypto";
        license = licenses.mit;
        description = "Fast ASN.1 parser and serializer with definitions for private keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, PKCS#12, PKCS#5, X.509 and TSP";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-17.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8b/0b/a06cfcb69d0cb004fde8bc6f0fd192d96d565d1b8aa2829f0f20adb796e5/attrs-17.4.0.tar.gz"; sha256 = "1c7960ccfd6a005cd9f7ba884e6316b5e430a3f1a6c37c5f87d8b43f83b54ec9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Sphinx"
      self."pytest"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f3/ec/bb6b384b5134fd881b91b6aa3a88ccddaad0103857760711a5ab8c799358/bcrypt-3.1.4.tar.gz"; sha256 = "67ed1a374c9155ec0840214ce804616de49c3df9c5bc66740687c1c9b1cd9e8d"; };
      doCheck = commonDoCheck;
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
      name = "certifi-2018.1.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/15/d4/2f888fc463d516ff7bf2379a4e9a552fef7f22a94147655d9b1097108248/certifi-2018.1.18.tar.gz"; sha256 = "edbc3f203427eef571f79a7692bb160a2b0f7ccaa31953e99bd17e307cf63f7d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.11.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"; sha256 = "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"; };
      doCheck = commonDoCheck;
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
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-6.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"; sha256 = "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/click";
        license = licenses.bsdOriginal;
        description = "A simple wrapper around optparse for powerful command line utilities.";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fd/2c/a9e42f90bda9ebadf4790ed699e44edd630614f1590eb42e11de64a0b9c1/cryptography-2.2.1.tar.gz"; sha256 = "dddad9d322a3f0867009ff9f25477b8f7c0bdbedf143704b384c9472f11cb2d3"; };
      doCheck = commonDoCheck;
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

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "effect" = python.mkDerivation {
      name = "effect-0.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8a/9a/25a881d1a48847ae95742a30ad0471d9fd71f28a506d30e09dc8cdf4b3ac/effect-0.11.0.tar.gz"; sha256 = "0607530ef589b59f907cfebcb681b5ed4ed56bff1fc2a5de430dcfa72ae1e5e0"; };
      doCheck = commonDoCheck;
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
      name = "idna-2.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"; sha256 = "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "imagesize" = python.mkDerivation {
      name = "imagesize-1.0.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c6/3f/1db2da33804e8d7ef3a868b27b7bdc1aae6a4f693f0162d2aeeaf503864f/imagesize-1.0.0.tar.gz"; sha256 = "5b326e4678b6925158ccc66a9fa3122b6106d7c876ee32d7de6ce59385b96315"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/imagesize_py";
        license = licenses.mit;
        description = "Getting image size from png/jpeg/jpeg2000/gif file";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-0.24";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/dc/b4/a60bcdba945c00f6d608d8975131ab3f25b22f2bcfe1dab221165194b2d4/itsdangerous-0.24.tar.gz"; sha256 = "cbb3fcf8d3e33df861709ecaf89d9e6629cff0a217bc2848f1b41cd30d360519"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/mitsuhiko/itsdangerous";
        license = licenses.bsdOriginal;
        description = "Various helpers to pass trusted data to untrusted environments and back.";
      };
    };

    "jinja2-cli" = python.mkDerivation {
      name = "jinja2-cli-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/50/24/a774867a93c19d21f132154b509ad014ab22106e1927d0241b556cf8c836/jinja2-cli-0.6.0.tar.gz"; sha256 = "4b1be17ce8a8f133df02205c3f0d3ebfc3a68e795d26987f846a2316636427b7"; };
      doCheck = commonDoCheck;
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

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-4.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/db/0b/f5660bf6299ec5b9f17bd36096fa8148a1c843fa77ddfddf9bebac9301f7/more-itertools-4.1.0.tar.gz"; sha256 = "c9ce7eccdcb901a2c75d326ea134e0886abfbea5f93e91cc95de9507c0816c44"; };
      doCheck = commonDoCheck;
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
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."click"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seppeljordan/nix-helpers";
        license = "GPL-3";
        description = "Utilities for working with Nix package manager";
      };
    };

    "nix-prefetch-github" = python.mkDerivation {
      name = "nix-prefetch-github-1.0";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/nix-prefetch-github"; sha256 = "0rg7viq00ljpsdyfpak598jq528a9w3fmlj86ayf0ld8rjrqyw26"; rev = "d5a34eced5509cc1f6ea63c1b2b79bfc04600b6d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."attrs"
      self."click"
      self."effect"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "UNKNOWN";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-17.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/77/32/439f47be99809c12ef2da8b60a2c47987786d2c6c9205549dd6ef95df8bd/packaging-17.1.tar.gz"; sha256 = "f019b770dd64e585a99714f1fd5e01c7a8f11b45635aa953fd41c689a657375b"; };
      doCheck = commonDoCheck;
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
      name = "paramiko-2.4.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/29/65/83181630befb17cd1370a6abb9a87957947a43c2332216e5975353f61d64/paramiko-2.4.1.tar.gz"; sha256 = "33e36775a6c71790ba7692a73f948b329cf9295a72b0102144b031114bd2a4f3"; };
      doCheck = commonDoCheck;
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
      name = "parsemon2-1.0";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/parsemon2"; sha256 = "0qlrgmi449jk9w3j091rh6qp1xq3lljyd6as310x575qvwa2ffvv"; rev = "ceb4db3d6b2a4f4e5d6154a6a6966c4f321ca05b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "GPL-3";
        description = "A monadic parser combinator written purely in python";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz"; sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f7/84/b4c6e84672c4ceb94f727f3da8344037b62cee960d80e999b1cd9b832d83/py-1.5.3.tar.gz"; sha256 = "29c9fab495d7528e80ba1e343b958684f4ace687327e6f789a94bf3d1915f881"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pyasn1" = python.mkDerivation {
      name = "pyasn1-0.4.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/eb/3d/b7d0fdf4a882e26674c68c20f40682491377c4db1439870f5b6f862f76ed/pyasn1-0.4.2.tar.gz"; sha256 = "d258b0a71994f7770599835249cece1caef3c70def868c4915e6e5ca49b67d15"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/etingof/pyasn1";
        license = licenses.bsdOriginal;
        description = "ASN.1 types and codecs";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"; sha256 = "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/eliben/pycparser";
        license = licenses.bsdOriginal;
        description = "C parser in Python";
      };
    };

    "pykube" = python.mkDerivation {
      name = "pykube-0.16a1";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/pykube"; sha256 = "0cfp83n9y8jfwzbz1pdgshrqzg7m27j3aqzz3xaphbl1k9lrsabj"; rev = "e8a46298a592ad9037587afb707ac75b3114eff9"; };
      doCheck = commonDoCheck;
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
      name = "pyparsing-2.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/3c/ec/a94f8cf7274ea60b5413df054f82a8980523efd712ec55a59e7c3357cf7c/pyparsing-2.2.0.tar.gz"; sha256 = "0832bcf47acd283788593e7a0f542407bd9550a55a8a8435214a1960e04bcb04"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyparsing.wikispaces.com/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pypi2nix" = python.mkDerivation {
      name = "pypi2nix-1.8.1";
      src = pkgs.fetchgit { url = "https://github.com/garbas/pypi2nix"; sha256 = "1ryivm71k3vbic57f7nqxwiw7zd00hd16hnrdqvz5gw869vnkd1d"; rev = "654c36cdb69572837cc242840e71361c156fd08d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."click"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/NixOS/pypi2nix";
        license = licenses.bsdOriginal;
        description = "A tool that generates nix expressions for your python packages, so you don't have to.";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2d/56/6019153cdd743300c5688ab3b07702355283e53c83fbf922242c053ffb7b/pytest-3.5.0.tar.gz"; sha256 = "fae491d1874f199537fd5872b5e1f0e74a009b979df9d53d1553fd03da1703e1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
      self."more-itertools"
      self."pluggy"
      self."py"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pytest.org";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2018.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1b/50/4cdc62fc0753595fc16c8f722a89740f487c6e5670c644eb8983946777be/pytz-2018.3.tar.gz"; sha256 = "410bcd1d6409026fbaa65d9ed33bf6dd8b1e94a499e32168acfc7b332e4095c0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.18.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b0/e1/eab4fc3752e3d240468a8c0b284607899d2fbfb236a56b7377a329aa8d09/requests-2.18.4.tar.gz"; sha256 = "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"; };
      doCheck = commonDoCheck;
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

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "snowballstemmer" = python.mkDerivation {
      name = "snowballstemmer-1.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/20/6b/d2a7cb176d4d664d94a6debf52cd8dbae1f7203c8e42426daa077051d59c/snowballstemmer-1.2.1.tar.gz"; sha256 = "919f26a68b2c17a7634da993d91339e288964f93c274f1343e3bbbe2096e1128"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/snowball_py";
        license = licenses.bsdOriginal;
        description = "This package provides 16 stemmer algorithms (15 + Poerter English stemmer) generated from Snowball algorithms.";
      };
    };

    "sphinxcontrib-websupport" = python.mkDerivation {
      name = "sphinxcontrib-websupport-1.0.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c5/6b/f0630436b931ad4f8331a9399ca18a7d447f0fcc0c7178fb56b1aee68d01/sphinxcontrib-websupport-1.0.1.tar.gz"; sha256 = "7a85961326aa3a400cd4ad3c816d70ed6f7c740acd7ce5d78cd0a67825072eb9"; };
      doCheck = commonDoCheck;
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
      name = "stormssh-0.6.9";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/07/b9/1ed919b9924003ea9abff0ff61116de5e5bac0675b9106fa6efbed10d030/stormssh-0.6.9.tar.gz"; sha256 = "e896597b902d1191bae1f6a9b248d3374258f8775e9726cff1ba2300ad664c8a"; };
      doCheck = commonDoCheck;
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

    "svm-nix-helpers" = python.mkDerivation {
      name = "svm-nix-helpers-1.0";
      src = pkgs.fetchgit { url = "https://github.com/schneevonmorgen/nix-helpers"; sha256 = "0sr9pzxd20yd2hgcdc30xvf41dbdpdq9pmcksjnj07zlxbzmbqyi"; rev = "8e6222348f4d028e903880fb8658f4ddcc22390e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/schneevonmorgen/nix-helpers";
        license = "";
        description = "Utilities for working with Nix package manager";
      };
    };

    "termcolor" = python.mkDerivation {
      name = "termcolor-1.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz"; sha256 = "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/termcolor";
        license = licenses.mit;
        description = "ANSII Color formatting for output in terminal.";
      };
    };

    "toml" = python.mkDerivation {
      name = "toml-0.9.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f5/f9/044110c267e6408013b85166a7cfcd352cf85275aa8ce700aa5c0eb407ba/toml-0.9.4.tar.gz"; sha256 = "8e86bd6ce8cc11b9620cb637466453d94f5d57ad86f17e98a98d1f73e3baab2d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = "License :: OSI Approved :: MIT License";
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "tzlocal" = python.mkDerivation {
      name = "tzlocal-1.5.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cb/89/e3687d3ed99bc882793f82634e9824e62499fdfdc4b1ae39e211c5b05017/tzlocal-1.5.1.tar.gz"; sha256 = "4ebeb848845ac898da6519b9b31879cf13b6626f7184c496037b818e238f2c4e"; };
      doCheck = commonDoCheck;
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
      name = "urllib3-1.22";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ee/11/7c59620aceedcc1ef65e156cc5ce5a24ef87be4107c2b74458464e437a5d/urllib3-1.22.tar.gz"; sha256 = "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"; };
      doCheck = commonDoCheck;
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

    "xmltodict" = python.mkDerivation {
      name = "xmltodict-0.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/57/17/a6acddc5f5993ea6eaf792b2e6c3be55e3e11f3b85206c818572585f61e1/xmltodict-0.11.0.tar.gz"; sha256 = "8f8d7d40aa28d83f4109a7e8aa86e67a4df202d9538be40c0cb1d70da527b0df"; };
      doCheck = commonDoCheck;
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
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (import ./python3_override.nix { inherit pkgs python ; })
    (let src = pkgs.fetchFromGitHub { owner = "garbas"; repo = "nixpkgs-python"; rev = "0b23ab59ca24ce4007c24abf2aa9232f3eb010c3"; sha256 = "0xzwchmppd8fsicmg2lzsq1zkirw7lc09ad7xr8r9336y4vnlmmx"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )