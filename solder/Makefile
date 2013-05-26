
default: scad

scad: output/top_end.stl output/bottom_end.stl

output/solder.stl: solder.scad
	openscad solder.scad -o output/solder.stl

output/top_end.stl: solder.scad
	sh ../bin/scad.sh 'use<'`pwd`'/solder.scad>; top_end();' \
		output/top_end.stl

output/bottom_end.stl: solder.scad
	sh ../bin/scad.sh 'use<'`pwd`'/solder.scad>; bottom_end();' \
		output/bottom_end.stl

