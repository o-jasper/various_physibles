
default:scad

scad: output/bit_part.stl output/gear.stl

output/bit_part.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; bit_part();' \
	output/bit_part.stl

output/gear.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; loose_gear();' \
	output/gear.stl

output/lower_body.stl: lower_body.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; lower_body();' \
	output/lower_body.stl

output/upper_body.stl: upper_body.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; upper_body();' \
	output/upper_body.stl
