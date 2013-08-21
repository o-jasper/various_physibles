
default: output/pants_hold_peg.stl \
	output/shorten_round_male.stl output/shorten_round_female.stl

output/pants_hold_peg.stl: pants_hold_peg.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pants_hold_peg.scad>; rotate([90,0,0]) pants_holder();' \
	output/pants_hold_peg.stl


output/shorten_round_male.stl: shorted_round.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/shorted_round.scad>; male();' \
	output/shorten_round_male.stl

output/shorten_round_female.stl: shorted_round.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/shorted_round.scad>; female();' \
	output/shorten_round_female.stl
