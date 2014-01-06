
default: scad

all: scad

scad: output/hanger.stl output/wheel.stl

output/%.stl: rider.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
