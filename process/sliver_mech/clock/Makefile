
default: clock

clock: stack_gears output/sliver_show.stl slivers arms

stack_gears: output/stack_gear_25,12.stl output/stack_gear_24,12.stl \
 output/stack_gear_24,12.stl \
 output/stack_gear_24,6.stl output/stack_gear_24,9.stl output/stack_gear_18,12.stl

slivers: output/sliver_0.stl output/sliver_1.stl output/sliver_2.stl output/sliver_3.stl \
	 output/sliver_4.stl output/sliver_5.stl output/sliver_6.stl output/sliver_7.stl \
	 output/sliver_8.stl output/sliver_9.stl output/sliver_10.stl output/sliver_11.stl

arms: output/seconds.stl output/minutes.stl output/hours.stl

#TODO top isnt sectioned?
output/stack_gear_%.stl: clock.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;stack_gear('`echo $@ | cut -f 3- -d_ |cut -f 1 -d.`');' \
		$@

output/sliver_%.stl: clock.scad 
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;sliver('`echo $@ | cut -f 2 -d_ |cut -f 1 -d.`');' \
		$@

output/%.stl: clock.scad 
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
