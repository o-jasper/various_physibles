
default: scad

scad: output/pill.stl output/fat_pill.stl output/pill_sub.stl output/pill_v_beam_35.stl

output/pill.stl: pill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pill.scad>;pill();'\
		output/pill.stl
output/fat_pill.stl: pill.scad #Slightly bigger pill for stronger fits.
	sh ../../bin/scad.sh 'use<'`pwd`'/pill.scad>;pill(R=7.25);'\
		output/fat_pill.stl

output/pill_sub.stl: pill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pill.scad>;pill_sub();'\
		output/pill_sub.stl

#NOTE: it is ridiculously short.
output/pill_v_beam_35.stl: pill.scad v_girder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/v_girder.scad>;pill_v_beam(l=35);'\
		output/pill_v_beam_35.stl
