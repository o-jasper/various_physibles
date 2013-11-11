
default: clock

clock: stack_gears output/sliver_show.stl slivers

stack_gears: output/stack_gear_25,12.stl output/stack_gear_24,12.stl \
 output/stack_gear_24,12.stl \
 output/stack_gear_24,6.stl output/stack_gear_24,9.stl output/stack_gear_18,12.stl

slivers: output/sliver_0.stl output/sliver_1.stl output/sliver_2.stl output/sliver_3.stl \
	 output/sliver_4.stl output/sliver_5.stl output/sliver_6.stl output/sliver_7.stl \
	 output/sliver_8.stl output/sliver_9.stl output/sliver_10.stl output/sliver_11.stl

planetary: output/planetary_wheel.stl output/planetary_body.stl output/planetary_center.stl \
	output/planetary_cap.stl output/planetary_handle.stl 

output/planetary_%.stl: planetary.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'planetary.scad'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d. | cut -f2 -d_`'();' \
		$@

#TODO top isnt sectioned?
output/stack_gear_%.stl: sliver_clock.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;stack_gear('`echo $@ | cut -f 3- -d_ |cut -f 1 -d.`');' \
		$@

output/sliver_%.stl: sliver_clock.scad gear_outer.scad	
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;sliver('`echo $@ | cut -f 2 -d_ |cut -f 1 -d.`');' \
		$@

output/%.stl: sliver_clock.scad gear_outer.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
