#!/bin/bash

pre()
{   echo "include<$PWD/params.scad>; use<$PWD/corner.scad>;use<$PWD/bed.scad>;"
    echo $(echo $2 | cut -f 2 -d/ |cut -f 1 -d.)'();'
}

FILE=/tmp/$RANDOM$(date +%s).scad
pre $@ > $FILE
openscad $FILE -o $2
rm $FILE
