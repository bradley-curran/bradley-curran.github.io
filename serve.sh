#!/bin/sh

set -e # exit when any command fails
set -v # echo commands

http-server docs -c-1 -o
