
default: scad

scad: output/bottom_end.stl output/ring.stl output/top.stl

output/bottom_end.stl: solder.scad
	sh ../bin/scad.sh 'use<'`pwd`'/solder.scad>; bottom_end();' \
		output/bottom_end.stl

output/ring.stl: solder.scad
	sh ../bin/scad.sh 'use<'`pwd`'/solder.scad>; holding_ring();' \
		output/ring.stl

output/top.stl: solder.scad
	sh ../bin/scad.sh 'use<'`pwd`'/solder.scad>; can_top();' \
	   output/top.stl


