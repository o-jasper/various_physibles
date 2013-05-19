
default:scad

scad: output/mirror_corner.stl output/mirror_stick_corner.stl

output/mirror_stick_corner.stl: corner_mirror.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/corner_mirror.scad>; mirror_stick_corner();' \
	output/mirror_stick_corner.stl

output/mirror_corner.stl: corner_mirror.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/corner_mirror.scad>; rotate([0,-90,0]) mirror_corner();' output/mirror_corner.stl

