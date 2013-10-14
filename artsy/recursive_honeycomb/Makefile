
#Not everything, duration of calcation goes up fast.
default: output/recursive_honeycomb_1.stl output/recursive_honeycomb_2.stl

all: default output/recursive_honeycomb_3.stl #Takes long.

output/%.stl: recursive_honeycomb.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
