
default: scad

all: escad scad

escad: output/clamp_pair.escad.stl 
scad: output/clamp_set.stl output/clamp_pair.stl output/clamp_spring.stl 

output/clamp_set.escad.stl: clamp.scad
	sh ../../bin/escad.sh 'include<'`pwd`'/clamp.scad>; as_print(true);' \
		output/clamp_set.escad.stl

output/clamp_set.stl: clamp.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/clamp.scad>; as_print(true);' \
		output/clamp_set.stl

output/clamp_pair.stl: clamp.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/clamp.scad>; as_print(false);' \
		output/clamp_pair.stl

output/clamp_spring.stl: clamp.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/clamp.scad>; plastic_spring();' \
		output/clamp_spring.stl
