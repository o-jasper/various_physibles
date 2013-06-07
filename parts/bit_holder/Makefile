
default: output/receive_part.stl output/drill_part.stl output/holder_part.stl


output/receive_part.stl: bit_holder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/bit_holder.scad>;rotate([0,90,0]) receive_part();' \
		output/receive_part.stl

output/drill_part.stl: bit_holder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/bit_holder.scad>;drill_part();' \
		output/drill_part.stl

output/holder_part.stl: bit_holder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/bit_holder.scad>;holder_part();' \
		output/holder_part.stl
