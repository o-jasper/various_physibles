
default:scad

all: scad

scad: output/slide_part.stl output/hang_part.stl output/x_stepper_filguide.stl

output/%.stl: spool_slider.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@

output/x_stepper_filguide.stl: x_stepper_filguide.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
