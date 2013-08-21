
default: output/pants_hold_peg.stl

output/pants_hold_peg.stl: pants_hold_peg.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pants_hold_peg.scad>; rotate([90,0,0]) pants_holder();' \
	output/pants_hold_peg.stl
