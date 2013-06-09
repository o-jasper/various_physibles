#!/bin/bash

FILE=/tmp/`date +%s`$RANDOM.escad
echo $1 > $FILE
extopenscad $FILE -o $2
admesh $2
