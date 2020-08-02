#!/bin/sh

VERSION=$1

if [ "X$VERSION" = "X" ]; then
    echo Error: you have to specify a version
    exit 2
fi

if ! [ -d packages ]; then
    echo Error: you must run this script at the top of the repository
    exit 2
fi

wget https://github.com/OCamlPro/opam-bin/archive/v${VERSION}.tar.gz -O output
CHECKSUM=$(sha256sum output | awk '{ print $1 }')
rm -f output
echo $CHECKSUM

rm -rf packages/opam-bin/opam-bin.$VERSION
cp -dpR packages/opam-bin/opam-bin.0.1.0 packages/opam-bin/opam-bin.$VERSION
sed -i "s|v0.1.0|v$VERSION|" packages/opam-bin/opam-bin.$VERSION/opam
sed -i "s|619dfd31eb5c97e34eb75506cc3b63f3baf035fdac557e57943bb10b37047d87|$CHECKSUM|" packages/opam-bin/opam-bin.$VERSION/opam

git add packages/opam-bin/opam-bin.$VERSION
