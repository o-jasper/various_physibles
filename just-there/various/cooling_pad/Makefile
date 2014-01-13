
default:scad

all: scad

scad: output/spiral_pad.stl

output/%.stl: spiral.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
