
default:scad

scad: output/vasable_maraca.stl output/just_show.stl output/vasable_maraca_no_stem.stl \
	output/shaker.stl output/vasable_shaker.stl

output/shaker.stl: shaker.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@; admesh $@ -b $@;

output/vasable_shaker.stl: shaker.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@; admesh $@ -b $@;

output/%.stl: maraca.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@; admesh $@ -b $@;
