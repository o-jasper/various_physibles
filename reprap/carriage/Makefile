
default:scad

all: scad

scad: output/carriage.stl output/rotate_lock.stl output/belt_holder_top.stl

output/%.stl: carriage.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
