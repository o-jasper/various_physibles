
default: planetary

planetary: output/planetary_wheel.stl output/planetary_body.stl output/planetary_cap.stl \
	output/planetary_center.stl output/planetary_handle.stl \

output/planetary_%.stl: planetary.scad ../gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'planetary.scad'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d. | cut -f2- -d_`'();' \
		$@
