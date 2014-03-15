#!/bin/bash

pre()
{   echo "include<$PWD/params.scad>; use<$PWD/corner.scad>;use<$PWD/bed.scad>;use<$PWD/fullp.scad>"
    MODULE=$(echo $2 | cut -f 2 -d/ |cut -f 1 -d.);
    if [ "$MODULE" == "show" ]; then
        echo 'show();'
    else
        echo $MODULE'($show=false);'
    fi
}

FILE=/tmp/$RANDOM$(date +%s).scad
pre $@ > $FILE
openscad $FILE -o $2
rm $FILE
