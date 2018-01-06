# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -v -V 3 -E libffi openssl -r python3.txt --default-overrides --basename python3
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

  commonBuildInputs = with pkgs; [ libffi openssl ];
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

    "Werkzeug" = python.mkDerivation {
      name = "Werkzeug-0.14.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9f/08/a3bb1c045ec602dc680906fc0261c267bed6b3bb4609430aff92c3888ec8/Werkzeug-0.14.1.tar.gz"; sha256 = "c3fd7a7d41976d9f44db327260e263132466836cef6f91512889ed60ad26557c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."termcolor"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.palletsprojects.org/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
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

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f3/ec/bb6b384b5134fd881b91b6aa3a88ccddaad0103857760711a5ab8c799358/bcrypt-3.1.4.tar.gz"; sha256 = "67ed1a374c9155ec0840214ce804616de49c3df9c5bc66740687c1c9b1cd9e8d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
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
      name = "certifi-2017.11.5";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/23/3f/8be01c50ed24a4bd6b8da799839066ce0288f66f5e11f0367323467f0cbc/certifi-2017.11.5.tar.gz"; sha256 = "5ec74291ca1136b40f0379e1128ff80e866597e4e2c1e755739a913bbc3613c0"; };
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
      name = "cffi-1.11.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c9/70/89b68b6600d479034276fed316e14b9107d50a62f5627da37fafe083fde3/cffi-1.11.2.tar.gz"; sha256 = "ab87dd91c0c4073758d07334c1e5f712ce8fe48f007b86f8238773963ee700a6"; };
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
      name = "cryptography-2.1.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/78/c5/7188f15a92413096c93053d5304718e1f6ba88b818357d05d19250ebff85/cryptography-2.1.4.tar.gz"; sha256 = "e4d967371c5b6b2e67855066471d844c5d52d210c36c28d49a8507b96e2c5291"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."asn1crypto"
      self."cffi"
      self."idna"
      self."pytz"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.bsdOriginal;
        description = "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
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
      self."toml"
      self."xmltodict"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mattrobenolt/jinja2-cli";
        license = licenses.bsdOriginal;
        description = "A CLI interface to Jinja2";
      };
    };

    "paramiko" = python.mkDerivation {
      name = "paramiko-2.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c8/de/791773d6a4b23327c7475ae3d7ada0d07fa147bf77fb6f561a4a7d8afd11/paramiko-2.4.0.tar.gz"; sha256 = "486f637f0a33a4792e0e567be37426c287efaa8c4c4a45e3216f9ce7fd70b1fc"; };
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

    "pypi2nix" = python.mkDerivation {
      name = "pypi2nix-1.8.1";
      src = pkgs.fetchgit { url = "https://github.com/seppeljordan/pypi2nix"; sha256 = "0y0ysm7x2myf6hl1ls5wf6sm53yaw8frqc47wl9i0rapgirbaxnn"; rev = "8126880c8f907f70438f70559f1756e7a656b855"; };
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

    "pytz" = python.mkDerivation {
      name = "pytz-2017.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/60/88/d3152c234da4b2a1f7a989f89609ea488225eaea015bc16fbde2b3fdfefa/pytz-2017.3.zip"; sha256 = "fae4cffc040921b8a2d60c6cf0b5d662c1190fe54d718271db4eb17d44a185b7"; };
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
        (let src = pkgs.fetchgit { url = "https://github.com/garbas/nixpkgs-python.git"; sha256 = "19xhcxw7d31gdbzmv5ki8wkzjz20i0b9kw7qm12n0cg2hxs512vi"; rev = "051b1616154ab0a9d0ed0c36f735d81839fe1872"; } ; in import "${src}/overrides.nix" { inherit pkgs python; })
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