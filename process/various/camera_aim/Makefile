
default: scad

all: scad

scad: output/side_servo.stl output/side_camera.stl output/servo_holder.stl output/base.stl

output/%.stl: camera_aim.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
