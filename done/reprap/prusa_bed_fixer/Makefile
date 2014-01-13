
default: output/bed_fixer.stl

output/%.stl: bed_fixer.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
