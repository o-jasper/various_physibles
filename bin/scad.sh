#!/bin/bash

mkdir -p `dirname $2`

FILE=/tmp/`date +%s`$RANDOM.scad
echo $1 > $FILE
openscad $FILE -o $2
