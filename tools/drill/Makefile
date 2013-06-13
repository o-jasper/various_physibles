
default:scad

scad: output/bit_part.stl output/gear.stl output/nob.stl output/lower_body.stl output/upper_body.stl 

output/bit_part.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; bit_part();' \
	output/bit_part.stl

output/gear.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; loose_gear();' \
	output/gear.stl

output/lower_body.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; lower_body();' \
	output/lower_body.stl

output/upper_body.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; rotate([0,-90]) upper_body();' \
	output/upper_body.stl

output/nob.stl: drill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/drill.scad>; gear_nob();' \
	output/nob.stl
