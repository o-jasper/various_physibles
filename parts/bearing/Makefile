
default: output/inner.stl output/outer_half.stl output/guide.stl

output/%.stl: bearing.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
