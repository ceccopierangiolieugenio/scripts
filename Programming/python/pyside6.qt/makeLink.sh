#!/bin/bash -x
rm -rf examples .venv
python3 -m venv .venv
. .venv/bin/activate ; \
  pip install pyside6
ln -s .venv/lib/python*/site-packages/PySide*/examples/