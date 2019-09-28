{ pkgs, python }:

self: super:
let

isPackage = package: drv:
  (builtins.parseDrvName drv.name).name ==
  "${python.__old.python.libPrefix}-${python.__old.python.libPrefix}-${package}";

filterPackages = packages:
  builtins.filter
  (x: builtins.all (package: ! isPackage package x) packages);

removePackages = packages: drv: drv.overrideDerivation (old: {
  propagatedBuildInputs =
    filterPackages packages old.propagatedBuildInputs;
  buildInputs =
    filterPackages packages old.buildInputs;
  doCheck = false;
});

setLanguage = drv: drv.overrideDerivation( old:
  {
    LC_ALL = "en_US.UTF-8";
  });

addBuildInputs = packages: drv: drv.overridePythonAttrs( old:
  {
    buildInputs = old.buildInputs ++
      builtins.map (x: self."${x}") packages;
  });

in
{

  "attrs" = removePackages ["pytest" "sphinx"] super."attrs";

  "cryptography" = removePackages ["pytest" "sphinx"] super."cryptography";

  "sphinx" = setLanguage (removePackages ["pytest"] super."sphinx");

  "flask" = removePackages ["pytest"] super."flask";

  "requests" = removePackages ["pytest"] super."requests";

  "py" = addBuildInputs ["setuptools-scm"] super."py";

  "parsemon2" = (addBuildInputs ["sphinx"] super.parsemon2).overridePythonAttrs( old:
    {
      preBuildPhases = [ "buildDocsPhase" ];
      preInstallPhases = [ "buildDocsPhase" "installDocsPhase" ];
      buildDocsPhase = ''
        OLD_PATH="$PATH"
        export PATH=${self.sphinx}/bin:$PATH
        export LC_ALL=C
        make man
        export PATH="$OLD_PATH"
      '';
      installDocsPhase = ''
        mkdir -p $out/share/man/man3
        cp build/man/parsemon2.3 $out/share/man/man3/parsemon2.3
      '';
    }
  );

  "pluggy" = addBuildInputs ["setuptools-scm"] super."pluggy";

  "zipp" = addBuildInputs ["setuptools-scm"] super."zipp";

  "importlib-metadata" = addBuildInputs ["setuptools-scm"] super."importlib-metadata";

  # "cymem" = addBuildInputs ["wheel"] super."cymem";
}
