{ mkDerivation, argparser, base, directory, filepath, json, process
, stdenv, temporary, transformers
}:
mkDerivation {
  pname = "update-tool";
  version = "0.1.0.0";
  src = /home/sebastian/src/update-tool;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    argparser base directory filepath json process temporary
    transformers
  ];
  license = stdenv.lib.licenses.gpl3;
}
