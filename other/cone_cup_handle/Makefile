
default:scad

all: scad

scad: output/cup_handler_42_31_107.stl

output/%.stl: cupfix.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
