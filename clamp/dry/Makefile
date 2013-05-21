
#Note probably mostly implicitCAD compatible.

default: scad

scad: output/clamp_set.stl output/clamp_pair.stl output/clamp_spring.stl\
output/tiny_set.stl output/tiny_pair.stl output/tiny_spring.stl  \
output/dry_set.stl output/dry_pair.stl output/dry_spring.stl 

output/clamp_set.stl: clamp.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/clamp.scad>; as_print(true);' \
		output/clamp_set.stl
output/clamp_pair.stl: clamp.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/clamp.scad>; as_print(false);' \
		output/clamp_pair.stl
output/clamp_spring.stl: clamp.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/clamp.scad>; plastic_spring();' \
		output/clamp_spring.stl

output/tiny_set.stl: clamp.scad tiny.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/tiny.scad>; as_print(true);' \
		output/tiny_set.stl
output/tiny_pair.stl: clamp.scad tiny.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/tiny.scad>; as_print(false);' \
		output/tiny_pair.stl
output/tiny_spring.stl: clamp.scad tiny.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/tiny.scad>; plastic_spring();' \
		output/tiny_spring.stl

output/dry_set.stl: clamp.scad dry.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/dry.scad>; as_print(true);' \
		output/dry_set.stl
output/dry_pair.stl: clamp.scad dry.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/dry.scad>; as_print(false);' \
		output/dry_pair.stl
output/dry_spring.stl: clamp.scad dry.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/dry.scad>; plastic_spring();' \
		output/dry_spring.stl

