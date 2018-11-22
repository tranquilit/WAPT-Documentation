#!/bin/sh
echo "clean"
make clean

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
#make latexpdf
