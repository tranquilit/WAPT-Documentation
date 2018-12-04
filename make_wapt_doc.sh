#!/bin/sh
set -e

echo "clean"
make clean

rm -Rf ./build/

echo "gettext and update po"
make gettext
sphinx-intl update -p build/locale/ -l fr

make clean
echo "make html English"
make htmlen

echo "make html French"
make -e SPHINXOPTS="-D language='fr'" htmlfr

echo "make epub/latex/etc.."
make epub
# we ignore errors from that build for now
make latexpdf  || true

cp ./robots.txt build/en/doc
cp ./robots.txt build/fr/doc
mkdir ./build/en/doc/.well-known
mkdir ./build/fr/doc/.well-known
cp security.txt ./build/en/doc/.well-known
cp security.txt ./build/en/doc/.well-known

