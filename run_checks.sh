#!/bin/bash
python3.5 -m sphinx.cmd.build -a -E source sphinx
make linkcheck
