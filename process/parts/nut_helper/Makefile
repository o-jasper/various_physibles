
default: output/nut_helper.stl output/nut_helper_thin.stl output/nut_winged.stl \
	output/screw_cap.stl

clean:
	rm output/*.stl

output/%.stl: nut_helper.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
