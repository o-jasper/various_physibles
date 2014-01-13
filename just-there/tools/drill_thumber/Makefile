default: output/top.stl output/bottom.stl

output/%.stl: thumber2.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
