
default:scad

all: scad

scad: output/spool_plank.stl output/split_spool_plankpart.stl output/split_spool_hangpart.stl \
	output/split_spool_plain.stl

output/%.stl: spool_plank.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
