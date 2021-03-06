# generated using pypi2nix tool (version: 2.0.3)
# See more at: https://github.com/nix-community/pypi2nix
#
# COMMAND:
#   pypi2nix -V python3 -E 'libsodium libffi libxml2 libxslt openssl' -r python3.txt --basename python3
#

{ pkgs ? import <nixpkgs> { }, overrides ? ({ pkgs, python }: self: super: { })
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
    import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
      inherit pkgs;
      inherit (pkgs) stdenv;
      python = pkgs.python3;
    };

  commonBuildInputs = with pkgs; [ libsodium libffi libxml2 libxslt openssl ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' [ "__unfix__" ];
      interpreterWithPackages = selectPkgsFn:
        pythonPackages.buildPythonPackage {
          name = "python3-interpreter";
          buildInputs = [ makeWrapper ] ++ (selectPkgsFn pkgs);
          buildCommand = ''
            mkdir -p $out/bin
            ln -s ${pythonPackages.python.interpreter} \
                $out/bin/${pythonPackages.python.executable}
            for dep in ${builtins.concatStringsSep " " (selectPkgsFn pkgs)}; do
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
      mkDerivation = args:
        pythonPackages.buildPythonPackage (args // {
          nativeBuildInputs = (args.nativeBuildInputs or [ ])
            ++ args.buildInputs;
        });
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage
        (drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; });
      withPackages = pkgs'': withPackages (pkgs // pkgs'');
    };

  python = withPackages { };

  generated = self: {
    "alabaster" = python.mkDerivation {
      name = "alabaster-0.7.12";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/cc/b4/ed8dcb0d67d5cfb7f83c4d5463a7614cb1d078ad7ae890c9143edebbf072/alabaster-0.7.12.tar.gz";
        sha256 =
          "a661d72d58e6ea8a57f7a86e37d86716863ee5e92788398526d58b26a4e4dc02";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://alabaster.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "A configurable sidebar-enabled Sphinx theme";
      };
    };

    "attrs" = python.mkDerivation {
      name = "attrs-19.3.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/98/c3/2c227e66b5e896e15ccdae2e00bbc69aa46e9a8ce8869cc5fa96310bf612/attrs-19.3.0.tar.gz";
        sha256 =
          "f7b7ce16570fe9965acd6d30101a28f62fb4a7f9e926b3bbc9b61f8b04247e72";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ self."setuptools" self."wheel" ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://www.attrs.org/";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };

    "babel" = python.mkDerivation {
      name = "babel-2.8.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/34/18/8706cfa5b2c73f5a549fdc0ef2e24db71812a2685959cff31cbdfc010136/Babel-2.8.0.tar.gz";
        sha256 =
          "1aac2ae2d0d8ea368fa90906567f5c08463d98ade155c0c4bfedd6a0f7160e38";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."pytz" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://babel.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "Internationalization utilities";
      };
    };

    "bcrypt" = python.mkDerivation {
      name = "bcrypt-3.1.7";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/fa/aa/025a3ab62469b5167bc397837c9ffc486c42a97ef12ceaa6699d8f5a5416/bcrypt-3.1.7.tar.gz";
        sha256 =
          "0b0069c752ec14172c5f78208f1863d7ad6755a6fae6fe76ec2c80d13be41e42";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."cffi" self."setuptools" self."wheel" ];
      propagatedBuildInputs = [ self."cffi" self."six" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/bcrypt/";
        license = licenses.asl20;
        description =
          "Modern password hashing for your software and your servers";
      };
    };

    "certifi" = python.mkDerivation {
      name = "certifi-2019.11.28";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/41/bf/9d214a5af07debc6acf7f3f257265618f1db242a3f8e49a9b516f24523a6/certifi-2019.11.28.tar.gz";
        sha256 =
          "25b64c7da4cd7479594d035c08c2d809eb4aab3a26e5a990ea98cc450c320f1f";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://certifi.io/";
        license = licenses.mpl20;
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };

    "cffi" = python.mkDerivation {
      name = "cffi-1.14.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/05/54/3324b0c46340c31b909fcec598696aaec7ddc8c18a63f2db352562d3354c/cffi-1.14.0.tar.gz";
        sha256 =
          "2d384f4a127a15ba701207f7639d94106693b6cd64173d6c8988e2c25f3ac2b6";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."pycparser" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://cffi.readthedocs.org";
        license = licenses.mit;
        description = "Foreign Function Interface for Python calling C code.";
      };
    };

    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz";
        sha256 =
          "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/chardet/chardet";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };

    "click" = python.mkDerivation {
      name = "click-7.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/f8/5c/f60e9d8a1e77005f664b76ff8aeaee5bc05d0a91798afd7f53fc998dbc47/Click-7.0.tar.gz";
        sha256 =
          "5b94b49521f6456670fdb30cd82a4eca9412788a93fa6dd6df72c94d5a8ff2d7";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/click/";
        license = licenses.bsdOriginal;
        description = "Composable command line interface toolkit";
      };
    };

    "cryptography" = python.mkDerivation {
      name = "cryptography-2.8";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/be/60/da377e1bed002716fb2d5d1d1cab720f298cb33ecff7bf7adea72788e4e4/cryptography-2.8.tar.gz";
        sha256 =
          "3cda1f0ed8747339bbdf71b9f38ca74c7b592f24f65cdb3ab3765e4b02871651";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."cffi" self."setuptools" self."wheel" ];
      propagatedBuildInputs = [ self."cffi" self."six" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/cryptography";
        license = licenses.asl20;
        description =
          "cryptography is a package which provides cryptographic recipes and primitives to Python developers.";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.16";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/2f/e0/3d435b34abd2d62e8206171892f174b180cd37b09d57b924ca5c2ef2219d/docutils-0.16.tar.gz";
        sha256 =
          "c2de3a60e9e7d07be26b7f2b00ca0309c207e06c100f9cc2a94931fc75a478fc";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "effect" = python.mkDerivation {
      name = "effect-1.1.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/31/7a/3c7a4568ed3a8fa463ffabbc70ed9471d82daad4e479b305d299bec72b49/effect-1.1.0.tar.gz";
        sha256 =
          "7affb603707c648b07b11781ebb793a4b9aee8acf1ac5764c3ed2112adf0c9ea";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."attrs" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/python-effect/effect/";
        license = licenses.mit;
        description = "pure effects for Python";
      };
    };

    "flask" = python.mkDerivation {
      name = "flask-1.1.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/2e/80/3726a729de758513fd3dbc64e93098eb009c49305a97c6751de55b20b694/Flask-1.1.1.tar.gz";
        sha256 =
          "13f9f196f330c7c2c5d7a5cf91af894110ca0215ac051b5844701f2bfd934d52";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs =
        [ self."click" self."itsdangerous" self."jinja2" self."werkzeug" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/flask/";
        license = licenses.bsdOriginal;
        description =
          "A simple framework for building complex web applications.";
      };
    };

    "idna" = python.mkDerivation {
      name = "idna-2.9";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/cb/19/57503b5de719ee45e83472f339f617b0c01ad75cba44aba1e4c97c2b0abd/idna-2.9.tar.gz";
        sha256 =
          "7588d1c14ae4c77d74036e8c22ff447b26d0fde8f007354fd48a7814db15b7cb";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kjd/idna";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };

    "imagesize" = python.mkDerivation {
      name = "imagesize-1.2.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/e4/9f/0452b459c8ba97e07c3cd2bd243783936a992006cf4cd1353c314a927028/imagesize-1.2.0.tar.gz";
        sha256 =
          "b1f6b5a4eab1f73479a50fb79fcf729514a900c341d8503d62a62dbc4127a2b1";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/shibukawa/imagesize_py";
        license = licenses.mit;
        description = "Getting image size from png/jpeg/jpeg2000/gif file";
      };
    };

    "importlib-metadata" = python.mkDerivation {
      name = "importlib-metadata-1.5.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/0d/e4/638f3bde506b86f62235c595073066e7b8472fc9ee2b8c6491347f31d726/importlib_metadata-1.5.0.tar.gz";
        sha256 =
          "06f5b3a99029c7134207dd882428a66992a9de2bef7c2b699b5641f9886c3302";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."setuptools" self."setuptools-scm" self."wheel" ];
      propagatedBuildInputs = [ self."zipp" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://importlib-metadata.readthedocs.io/";
        license = licenses.asl20;
        description = "Read metadata from Python packages";
      };
    };

    "itsdangerous" = python.mkDerivation {
      name = "itsdangerous-1.1.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/68/1a/f27de07a8a304ad5fa817bbe383d1238ac4396da447fa11ed937039fa04b/itsdangerous-1.1.0.tar.gz";
        sha256 =
          "321b033d07f2a4136d3ec762eac9f16a10ccd60f53c0c91af90217ace7ba1f19";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/itsdangerous/";
        license = licenses.bsdOriginal;
        description =
          "Various helpers to pass data to untrusted environments and back.";
      };
    };

    "jinja2" = python.mkDerivation {
      name = "jinja2-2.11.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/d8/03/e491f423379ea14bb3a02a5238507f7d446de639b623187bccc111fbecdf/Jinja2-2.11.1.tar.gz";
        sha256 =
          "93187ffbc7808079673ef52771baa950426fd664d3aad1d0fa3e95644360e250";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."markupsafe" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/jinja/";
        license = licenses.bsdOriginal;
        description = "A very fast and expressive template engine.";
      };
    };

    "jinja2-cli" = python.mkDerivation {
      name = "jinja2-cli-0.7.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/23/67/6f05f5f8a9fc108c58e4eac9b9b7876b400985d33149fe2faa87a9ca502b/jinja2-cli-0.7.0.tar.gz";
        sha256 =
          "9ccd8d530dad5d031230afd968cf54637b49842a13ececa6e17c2f67f6e9336e";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."jinja2" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mattrobenolt/jinja2-cli";
        license = licenses.bsdOriginal;
        description = "A CLI interface to Jinja2";
      };
    };

    "jsonschema" = python.mkDerivation {
      name = "jsonschema-3.2.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/69/11/a69e2a3c01b324a77d3a7c0570faa372e8448b666300c4117a516f8b1212/jsonschema-3.2.0.tar.gz";
        sha256 =
          "c8a85b28d377cc7737e46e2d9f2b4f44ee3c0e1deac6bf46ddefc7187d30797a";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."setuptools" self."setuptools-scm" self."wheel" ];
      propagatedBuildInputs = [
        self."attrs"
        self."importlib-metadata"
        self."pyrsistent"
        self."setuptools"
        self."six"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/Julian/jsonschema";
        license = licenses.mit;
        description = "An implementation of JSON Schema validation for Python";
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
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."effect" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = "UNKNOWN";
        description = "UNKNOWN";
      };
    };

    "lxml" = python.mkDerivation {
      name = "lxml-4.5.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/39/2b/0a66d5436f237aff76b91e68b4d8c041d145ad0a2cdeefe2c42f76ba2857/lxml-4.5.0.tar.gz";
        sha256 =
          "8620ce80f50d023d414183bf90cc2576c2837b88e00bea3f33ad2630133bbb60";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://lxml.de/";
        license = licenses.bsdOriginal;
        description =
          "Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API.";
      };
    };

    "markupsafe" = python.mkDerivation {
      name = "markupsafe-1.1.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/b9/2e/64db92e53b86efccfaea71321f597fa2e1b2bd3853d8ce658568f7a13094/MarkupSafe-1.1.1.tar.gz";
        sha256 =
          "29872e92839765e546828bb7754a68c418d927cd064fd4708fab9fe9c8bb116b";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/markupsafe/";
        license = licenses.bsdOriginal;
        description = "Safely add untrusted strings to HTML/XML markup.";
      };
    };

    "more-itertools" = python.mkDerivation {
      name = "more-itertools-8.2.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/a0/47/6ff6d07d84c67e3462c50fa33bf649cda859a8773b53dc73842e84455c05/more-itertools-8.2.0.tar.gz";
        sha256 =
          "b1ddb932186d8a6ac451e1d95844b382f55e12686d51ca0c68b6f61f2ab7a507";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/erikrose/more-itertools";
        license = licenses.mit;
        description =
          "More routines for operating on iterables, beyond itertools";
      };
    };

    "nix-prefetch-github" = python.mkDerivation {
      name = "nix-prefetch-github-2.3.2";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/nix-prefetch-github";
        sha256 = "0shw5a28idyz9b1lbnphzq65gn2xybn6padf37m2ij1kiiczzvri";
        rev = "6e1d1b7e33b81c059bcfba8010c0cbd4b43eddf7";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs =
        [ self."attrs" self."click" self."effect" self."jinja2" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/seppeljordan/nix-prefetch-github";
        license = "GPLv3";
        description = "Prefetch source code from github for nix build tool";
      };
    };

    "packaging" = python.mkDerivation {
      name = "packaging-20.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/7b/d5/199f982ae38231995276421377b72f4a25d8251f4fa56f6be7cfcd9bb022/packaging-20.1.tar.gz";
        sha256 =
          "e665345f9eef0c621aa0bf2f8d78cf6d21904eef16a93f020240b704a57f1334";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."pyparsing" self."six" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/packaging";
        license = licenses.asl20;
        description = "Core utilities for Python packages";
      };
    };

    "paramiko" = python.mkDerivation {
      name = "paramiko-2.7.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/ac/15/4351003352e11300b9f44a13576bff52dcdc6e4a911129c07447bda0a358/paramiko-2.7.1.tar.gz";
        sha256 =
          "920492895db8013f6cc0179293147f830b8c7b21fdfc839b6bad760c27459d9f";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs =
        [ self."bcrypt" self."cryptography" self."pynacl" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/paramiko/paramiko/";
        license = licenses.lgpl2;
        description = "SSH2 protocol library";
      };
    };

    "parsemon2" = python.mkDerivation {
      name = "parsemon2-3.0.1";
      src = pkgs.fetchgit {
        url = "https://github.com/seppeljordan/parsemon2";
        sha256 = "0bzwm9s62g5wwnhrhmq2r7yrywn8f0478hyqx27bg5vzsykd3b2g";
        rev = "66498f9f8f08f42a28f4d76e6d8627a70afa17a2";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."attrs" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "UNKNOWN";
        license = "GPLv3";
        description = "A monadic parser combinator written purely in python";
      };
    };

    "parsley" = python.mkDerivation {
      name = "parsley-1.3";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/06/52/cac2f9e78c26cff8bb518bdb4f2b5a0c7058dec7a62087ed48fe87478ef0/Parsley-1.3.tar.gz";
        sha256 =
          "9444278d47161d5f2be76a767809a3cbe6db4db822f46a4fd7481d4057208d41";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://launchpad.net/parsley";
        license = licenses.mit;
        description = "Parsing and pattern matching made easy.";
      };
    };

    "pluggy" = python.mkDerivation {
      name = "pluggy-0.13.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/f8/04/7a8542bed4b16a65c2714bf76cf5a0b026157da7f75e87cc88774aa10b14/pluggy-0.13.1.tar.gz";
        sha256 =
          "15b2acde666561e1298d71b523007ed7364de07029219b604cf808bfa1c765b0";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."setuptools" self."setuptools-scm" self."wheel" ];
      propagatedBuildInputs = [ self."importlib-metadata" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pytest-dev/pluggy";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };

    "py" = python.mkDerivation {
      name = "py-1.8.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/bd/8f/169d08dcac7d6e311333c96b63cbe92e7947778475e1a619b674989ba1ed/py-1.8.1.tar.gz";
        sha256 =
          "5e27081401262157467ad6e7f851b7aa402c5852dbcb3dae06768434de5752aa";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://py.readthedocs.io/";
        license = licenses.mit;
        description =
          "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };

    "pycparser" = python.mkDerivation {
      name = "pycparser-2.19";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/68/9e/49196946aee219aead1290e00d1e7fdeab8567783e83e1b9ab5585e6206a/pycparser-2.19.tar.gz";
        sha256 =
          "a988718abfad80b6b157acce7bf130a30876d27603738ac39f140993246b25b3";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
        url =
          "https://files.pythonhosted.org/packages/58/56/3e84f2c1f2e39b9ea132460183f123af41e3b9c8befe222a35636baa6a5a/pydbus-0.6.0.tar.gz";
        sha256 =
          "4207162eff54223822c185da06c1ba8a34137a9602f3da5a528eedf3f78d0f2c";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/LEW21/pydbus";
        license = licenses.lgpl2Plus;
        description = "Pythonic DBus library";
      };
    };

    "pygments" = python.mkDerivation {
      name = "pygments-2.5.2";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/cb/9f/27d4844ac5bf158a33900dbad7985951e2910397998e85712da03ce125f0/Pygments-2.5.2.tar.gz";
        sha256 =
          "98c8aa5a9f778fcd1026a17361ddaf7330d1b7c62ae97c3bb0ae73e0b9b6b0fe";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description =
          "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "pynacl" = python.mkDerivation {
      name = "pynacl-1.3.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/61/ab/2ac6dea8489fa713e2b4c6c5b549cc962dd4a842b5998d9e80cf8440b7cd/PyNaCl-1.3.0.tar.gz";
        sha256 =
          "0c6100edd16fefd1557da078c7a31e7b7d7a52ce39fdca2bec29d4f7b6e7600c";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."cffi" self."setuptools" self."wheel" ];
      propagatedBuildInputs = [ self."cffi" self."six" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyca/pynacl/";
        license = licenses.asl20;
        description =
          "Python binding to the Networking and Cryptography (NaCl) library";
      };
    };

    "pyparsing" = python.mkDerivation {
      name = "pyparsing-2.4.6";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/a2/56/0404c03c83cfcca229071d3c921d7d79ed385060bbe969fde3fd8f774ebd/pyparsing-2.4.6.tar.gz";
        sha256 =
          "4c830582a84fb022400b85429791bc551f1f4871c33f23e44f353119e92f969f";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pyparsing/pyparsing/";
        license = licenses.mit;
        description = "Python parsing module";
      };
    };

    "pypi2nix" = python.mkDerivation {
      name = "pypi2nix-2.0.4";
      src = pkgs.fetchgit {
        url = "https://github.com/nix-community/pypi2nix";
        sha256 = "0zi7p9rx44r6kh8b6a1zr0zf1b5yw99w8r0kjync9hff9xpv8r5f";
        rev = "aedd800c0bd70612d5b2b9a7d62a9c050de76113";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."attrs"
        self."click"
        self."jinja2"
        self."jsonschema"
        self."nix-prefetch-github"
        self."packaging"
        self."parsley"
        self."setuptools"
        self."setuptools-scm"
        self."toml"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/nix-community/pypi2nix";
        license = licenses.bsdOriginal;
        description =
          "A tool that generates nix expressions for your python packages, so you do not have to.";
      };
    };

    "pyrsistent" = python.mkDerivation {
      name = "pyrsistent-0.15.7";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/90/aa/cdcf7ef88cc0f831b6f14c8c57318824c9de9913fe8de38e46a98c069a35/pyrsistent-0.15.7.tar.gz";
        sha256 =
          "cdc7b5e3ed77bed61270a47d35434a30617b9becdf2478af76ad2c6ade307280";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ self."six" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/tobgu/pyrsistent/";
        license = licenses.mit;
        description = "Persistent/Functional/Immutable data structures";
      };
    };

    "pytest" = python.mkDerivation {
      name = "pytest-5.3.5";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/f0/5f/41376614e41f7cdee02d22d1aec1ea028301b4c6c4523a5f7ef8e960fe0b/pytest-5.3.5.tar.gz";
        sha256 =
          "0d5fe9189a148acc3c3eb2ac8e1ac0742cb7618c084f3d228baaec0c254b318d";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."setuptools" self."setuptools-scm" self."wheel" ];
      propagatedBuildInputs = [
        self."attrs"
        self."importlib-metadata"
        self."more-itertools"
        self."packaging"
        self."pluggy"
        self."py"
        self."wcwidth"
      ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://docs.pytest.org/en/latest/";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2019.3";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/82/c3/534ddba230bd4fbbd3b7a3d35f3341d014cca213f369a9940925e7e5f691/pytz-2019.3.tar.gz";
        sha256 =
          "b02c06db6cf09c12dd25137e563b31700d3b80fcc4ad23abb7a315f2789819be";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "pyyaml" = python.mkDerivation {
      name = "pyyaml-5.3";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/3d/d9/ea9816aea31beeadccd03f1f8b625ecf8f645bd66744484d162d84803ce5/PyYAML-5.3.tar.gz";
        sha256 =
          "e9f45bd5b92c7974e59bcd2dcc8631a6b6cc380a904725fce7bc08872e691615";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/yaml/pyyaml";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "requests" = python.mkDerivation {
      name = "requests-2.23.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/f5/4f/280162d4bd4d8aad241a21aecff7a6e46891b905a4341e7ab549ebaf7915/requests-2.23.0.tar.gz";
        sha256 =
          "b3f43d496c6daba4493e7c431722aeb7dbc6288f52a6e04e7b6023b0247817e6";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs =
        [ self."certifi" self."chardet" self."idna" self."urllib3" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://requests.readthedocs.io";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };

    "setuptools" = python.mkDerivation {
      name = "setuptools-45.2.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/68/75/d1d7b7340b9eb6e0388bf95729e63c410b381eb71fe8875cdfd949d8f9ce/setuptools-45.2.0.zip";
        sha256 =
          "89c6e6011ec2f6d57d43a3f9296c4ef022c2cbf49bab26b407fe67992ae3397f";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools";
        license = licenses.mit;
        description =
          "Easily download, build, install, upgrade, and uninstall Python packages";
      };
    };

    "setuptools-scm" = python.mkDerivation {
      name = "setuptools-scm-3.5.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/b2/f7/60a645aae001a2e06cf4b8db2fba9d9f36b8fd378f10647e3e218b61b74b/setuptools_scm-3.5.0.tar.gz";
        sha256 =
          "5bdf21a05792903cafe7ae0c9501182ab52497614fa6b1750d9dbae7b60c1a87";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs ++ [ self."setuptools" self."wheel" ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/setuptools_scm/";
        license = licenses.mit;
        description = "the blessed package to manage your versions by scm tags";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.14.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/21/9f/b251f7f8a76dec1d6651be194dfba8fb8d7781d10ab3987190de8391d08e/six-1.14.0.tar.gz";
        sha256 =
          "236bdbdce46e6e6a3d61a337c0f8b763ca1e8717c03b369e87a7ec7ce1319c0a";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/benjaminp/six";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "snowballstemmer" = python.mkDerivation {
      name = "snowballstemmer-2.0.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/21/1b/6b8bbee253195c61aeaa61181bb41d646363bdaa691d0b94b304d4901193/snowballstemmer-2.0.0.tar.gz";
        sha256 =
          "df3bac3df4c2c01363f3dd2cfa78cce2840a79b9f1c2d2de9ce8d31683992f52";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/snowballstem/snowball";
        license = licenses.bsdOriginal;
        description =
          "This package provides 26 stemmers for 25 languages generated from Snowball algorithms.";
      };
    };

    "sphinx" = python.mkDerivation {
      name = "sphinx-2.4.3";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/35/e2/7efb490c116fa1a06a7c4c82ae5fd1510d7098b8ca76c31c0135828906f9/Sphinx-2.4.3.tar.gz";
        sha256 =
          "ca762da97c3b5107cbf0ab9e11d3ec7ab8d3c31377266fd613b962ed971df709";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [
        self."alabaster"
        self."babel"
        self."docutils"
        self."imagesize"
        self."jinja2"
        self."packaging"
        self."pygments"
        self."requests"
        self."setuptools"
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

    "sphinxcontrib-applehelp" = python.mkDerivation {
      name = "sphinxcontrib-applehelp-1.0.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/1b/71/8bafa145e48131049dd4f731d6f6eeefe0c34c3017392adbec70171ad407/sphinxcontrib-applehelp-1.0.1.tar.gz";
        sha256 =
          "edaa0ab2b2bc74403149cb0209d6775c96de797dfd5b5e2a71981309efab3897";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
        url =
          "https://files.pythonhosted.org/packages/57/5f/bf9a0f7454df68a7a29033a5cf8d53d0797ae2e426b1b419e4622726ec7d/sphinxcontrib-devhelp-1.0.1.tar.gz";
        sha256 =
          "6c64b077937330a9128a4da74586e8c2130262f014689b4b89e2d08ee7294a34";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "";
        description = "";
      };
    };

    "sphinxcontrib-htmlhelp" = python.mkDerivation {
      name = "sphinxcontrib-htmlhelp-1.0.3";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/c9/2e/a7a5fef38327b7f643ed13646321d19903a2f54b0a05868e4bc34d729e1f/sphinxcontrib-htmlhelp-1.0.3.tar.gz";
        sha256 =
          "e8f5bb7e31b2dbb25b9cc435c8ab7a79787ebf7f906155729338f3156d93659b";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description =
          "sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files";
      };
    };

    "sphinxcontrib-jsmath" = python.mkDerivation {
      name = "sphinxcontrib-jsmath-1.0.1";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/b2/e8/9ed3830aeed71f17c026a07a5097edcf44b692850ef215b161b8ad875729/sphinxcontrib-jsmath-1.0.1.tar.gz";
        sha256 =
          "a9925e4a4587247ed2191a22df5f6970656cb8ca2bd6284309578f2153e0c4b8";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://sphinx-doc.org/";
        license = licenses.bsdOriginal;
        description =
          "A sphinx extension which renders display math in HTML via JavaScript";
      };
    };

    "sphinxcontrib-qthelp" = python.mkDerivation {
      name = "sphinxcontrib-qthelp-1.0.2";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/0c/f0/690cd10603e3ea8d184b2fffde1d965dd337b87a1d5f7625d0f6791094f4/sphinxcontrib-qthelp-1.0.2.tar.gz";
        sha256 =
          "79465ce11ae5694ff165becda529a600c754f4bc459778778c7017374d4d406f";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
        url =
          "https://files.pythonhosted.org/packages/cd/cc/fd7d17cfae18e5a92564bb899bc05e13260d7a633f3cffdaad4e5f3ce46a/sphinxcontrib-serializinghtml-1.1.3.tar.gz";
        sha256 =
          "c0efb33f8052c04fd7a26c0a07f1678e8512e0faec19f4aa8f2473a8b81d5227";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
        url =
          "https://files.pythonhosted.org/packages/0a/18/85d12be676ae0c1d98173b07cc289bbf9e0c67d6c7054b8df3e1003bf992/stormssh-0.7.0.tar.gz";
        sha256 =
          "8d034dcd9487fa0d280e0ec855d08420f51d5f9f2249f932e3c12119eaa53453";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs =
        [ self."flask" self."paramiko" self."six" self."termcolor" ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/emre/storm";
        license = licenses.mit;
        description = "Management commands to ssh config files.";
      };
    };

    "termcolor" = python.mkDerivation {
      name = "termcolor-1.1.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/8a/48/a76be51647d0eb9f10e2a4511bf3ffb8cc1e6b14e9e4fab46173aa79f981/termcolor-1.1.0.tar.gz";
        sha256 =
          "1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
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
        url =
          "https://files.pythonhosted.org/packages/b9/19/5cbd78eac8b1783671c40e34bb0fa83133a06d340a38b55c645076d40094/toml-0.10.0.tar.gz";
        sha256 =
          "229f81c57791a41d65e399fc06bf0848bab550a9dfd5ed66df18ce5f05e73d5c";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/uiri/toml";
        license = licenses.mit;
        description = "Python Library for Tom's Obvious, Minimal Language";
      };
    };

    "urllib3" = python.mkDerivation {
      name = "urllib3-1.25.8";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/09/06/3bc5b100fe7e878d3dee8f807a4febff1a40c213d2783e3246edde1f3419/urllib3-1.25.8.tar.gz";
        sha256 =
          "87716c2d2a7121198ebcb7ce7cccf6ce5e9ba539041cfbaeecfb641dc0bf6acc";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://urllib3.readthedocs.io/";
        license = licenses.mit;
        description =
          "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };

    "wcwidth" = python.mkDerivation {
      name = "wcwidth-0.1.8";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/5e/33/92333eb80be0c96385dee338f30b53e24a8b415d5785e225d789b3f90feb/wcwidth-0.1.8.tar.gz";
        sha256 =
          "f28b3e8a6483e5d49e7f8949ac1a78314e740333ae305b4ba5defd3e74fb37a8";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jquast/wcwidth";
        license = licenses.mit;
        description =
          "Measures number of Terminal column cells of wide-character codes";
      };
    };

    "werkzeug" = python.mkDerivation {
      name = "werkzeug-1.0.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/4b/a5/781dbff5062f31e8407242ea2e07c05eb4f3a236f59124ef46f5e92a2776/Werkzeug-1.0.0.tar.gz";
        sha256 =
          "169ba8a33788476292d04186ab33b01d6add475033dfc07215e6d219cc077096";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://palletsprojects.com/p/werkzeug/";
        license = licenses.bsdOriginal;
        description = "The comprehensive WSGI web application library.";
      };
    };

    "wheel" = python.mkDerivation {
      name = "wheel-0.34.2";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/75/28/521c6dc7fef23a68368efefdcd682f5b3d1d58c2b90b06dc1d0b805b51ae/wheel-0.34.2.tar.gz";
        sha256 =
          "8788e9155fe14f54164c1b9eb0a319d98ef02c160725587ad60f14ddc57b6f96";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ self."setuptools" ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pypa/wheel";
        license = licenses.mit;
        description = "A built-package format for Python";
      };
    };

    "xmltodict" = python.mkDerivation {
      name = "xmltodict-0.12.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/58/40/0d783e14112e064127063fbf5d1fe1351723e5dfe9d6daad346a305f6c49/xmltodict-0.12.0.tar.gz";
        sha256 =
          "50d8c638ed7ecb88d90561beedbf720c9b4e851a9fa6c47ebd64e99d166d8a21";
      };
      doCheck = commonDoCheck;
      format = "setuptools";
      buildInputs = commonBuildInputs ++ [ ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/martinblech/xmltodict";
        license = licenses.mit;
        description =
          "Makes working with XML feel like you are working with JSON";
      };
    };

    "zipp" = python.mkDerivation {
      name = "zipp-3.0.0";
      src = pkgs.fetchurl {
        url =
          "https://files.pythonhosted.org/packages/42/09/bb2a28216f9572da61a2c56c6d5bf6d8c011371d8268f42a9ca5a4cbaf40/zipp-3.0.0.tar.gz";
        sha256 =
          "7c0f8e91abc0dc07a5068f315c52cb30c66bfbc581e5b50704c8a2f6ebae794a";
      };
      doCheck = commonDoCheck;
      format = "pyproject";
      buildInputs = commonBuildInputs
        ++ [ self."setuptools" self."setuptools-scm" self."wheel" ];
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/jaraco/zipp";
        license = licenses.mit;
        description =
          "Backport of pathlib-compatible object wrapper for zip files";
      };
    };
  };
  localOverridesFile = ./python3_override.nix;
  localOverrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
    (let
      src = pkgs.fetchFromGitHub {
        owner = "nix-community";
        repo = "pypi2nix-overrides";
        rev = "100c15ec7dfe7d241402ecfb1e796328d0eaf1ec";
        sha256 = "0akfkvdakcdxc1lrxznh1rz2811x4pafnsq3jnyr5pn3m30pc7db";
      };
    in import "${src}/overrides.nix" { inherit pkgs python; })
  ];
  paramOverrides = [ (overrides { inherit pkgs python; }) ];
  allOverrides = (if (builtins.pathExists localOverridesFile) then
    [ localOverrides ]
  else
    [ ]) ++ commonOverrides ++ paramOverrides;

in python.withPackages (fix' (pkgs.lib.fold extends generated allOverrides))
