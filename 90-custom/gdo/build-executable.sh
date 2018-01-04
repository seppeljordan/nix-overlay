source $stdenv/setup

TEMPDIR=$(mktemp -d)

trap "echo \"remove temp dir\" ; rm -rf $TEMPDIR" SIGINT SIGTERM EXIT

cd $TEMPDIR
if [ -d $src ] ; then
    pushd $src
    cabal sdist --output-directory=$TEMPDIR
    popd
else
    tar xzvf $src
    cd gdo-${version}
fi

cat <<EOF > environment
#!/usr/bin/env sh

CORES=1
HC="ghc -j${CORES} -v0 -O2 -Wall -hide-package cryptohash"
PANDOC=pandoc
EOF

rm .gdo -rf
gdo gdo
mkdir -p $out/bin
cp gdo $out/bin/

patchShebangs man/*.do *.do
gdo man/gdo.1
mkdir -p $out/share/man/man1
cp man/gdo.1 $out/share/man/man1
