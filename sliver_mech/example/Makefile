
default: pair

pair: output/pair_pgear.stl output/pair_holder.stl

output/pair_%.stl: pair.scad ../gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2- -d_ |cut -f 1 -d.`'();' \
		$@

output/%.stl: sliver_clock.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
