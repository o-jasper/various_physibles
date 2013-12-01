
default:scad

all: scad

scad: output/top.stl output/bottom.stl

output/%.stl: mouse_platform.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
