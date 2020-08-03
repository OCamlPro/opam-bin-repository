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

wget https://github.com/OCamlPro/ez-file/archive/v${VERSION}.tar.gz -O output
CHECKSUM=$(sha256sum output | awk '{ print $1 }')
rm -f output
echo $CHECKSUM

rm -rf packages/ez-file/ez-file.$VERSION
cp -dpR attic/ez-file.template packages/ez-file/ez-file.$VERSION
sed -i "s|v0.1.0|v$VERSION|" packages/ez-file/ez-file.$VERSION/opam
sed -i "s|63427d15cbf9b98c6a1ac795eea37e38cfe2addc7c8561275270c24b0b5d56c0|$CHECKSUM|" packages/ez-file/ez-file.$VERSION/opam

git add packages/ez-file/ez-file.$VERSION
