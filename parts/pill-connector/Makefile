
default: scad

scad: output/pill.stl output/pill_v_beam_25.stl


output/pill.stl: pill.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pill.scad>;pill();'\
		output/pill.stl

#NOTE: it is ridiculously short.
output/pill_v_beam_25.stl: pill.scad v_girder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/v_girder.scad>;pill_v_beam(l=25);'\
		output/pill_v_beam_25.stl
