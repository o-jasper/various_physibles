
default: clock

clock: stack_gears output/sliver_show.stl

stack_gears: output/stack_gear_25,12.stl output/stack_gear_24,12.stl \
 output/stack_gear_24,12.stl \
 output/stack_gear_24,6.stl output/stack_gear_24,9.stl output/stack_gear_18,12.stl

planetary: output/planetary_wheel.stl output/planetary_body.stl output/planetary_center.stl

output/%.stl: planetary.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'planetary.scad'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d. | cut -f2 -d_`'();' \
		$@

#TODO top isnt sectioned?
output/stack_gear_%.stl: sliver_clock.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;stack_gear('`echo $@ | cut -f 3- -d_ |cut -f 1 -d.`');' \
		$@

output/%.stl: sliver_clock.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
