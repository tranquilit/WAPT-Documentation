#!/bin/sh

export http_proxy=http://srvproxy:8080
export https_proxy=http://srvproxy:8080

echo "clean"
make clean

echo "make html English"
make htmlen

# ./build/fr/doc/index.html
