
default:scad

scad: output/recursive_tree.stl output/recursive_cupoid.stl output/recursive_spheroid.stl \
	output/vtree.stl

output/recursive_tree.stl: recursive_tree.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/recursive_tree.scad>; recursive_tree();' \
	output/recursive_tree.stl

output/recursive_cupoid.stl: recursive_tree.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/recursive_tree.scad>; recursive_cupoid();' \
	output/recursive_cupoid.stl

output/recursive_spheroid.stl: recursive_tree.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/recursive_tree.scad>; recursive_spheroid();' \
	output/recursive_spheroid.stl

output/vtree.stl: vtree.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/vtree.scad>; whole_tree();' \
	output/vtree.stl
