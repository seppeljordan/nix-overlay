{ pkgs, python }:

self: super: {

  "parsemon2" = super.parsemon2.overrideDerivation( old:
    {
      postPhases = [ "buildDocsPhase" "installDocsPhase" ];
      buildInputs = old.buildInputs ++ [ self."Sphinx" ];
      buildDocsPhase = ''
        make man
      '';
      installDocsPhase = ''
        mkdir -p $out/share/man/man3
        cp build/man/parsemon2.3 $out/share/man/man3/parsemon2.3
      '';
    }
  );

  "xdg" = super.xdg.overrideDerivation( old:
    {
      patchPhase = ''
        sed -i -e "s|'pytest\-runner'||" setup.py
      '';
    });

  "pydbus" = super.pydbus.overrideDerivation( old:
    {
      propagatedBuildInputs = old.propagatedBuildInputs ++ [ self."PyGObject" ];
    }
  );

  "PyGObject" = super."PyGObject".overrideDerivation( old:
    {

    }
  );
    
}
