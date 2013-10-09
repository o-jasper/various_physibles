
default:scad

scad: output/maraca.stl output/just_show.stl output/maraca_no_stem.stl

output/%.stl: maraca.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
