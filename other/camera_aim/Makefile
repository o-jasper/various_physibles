
default: output/side_servo.stl output/side_camera.stl output/servo_holder.stl output/base.stl

output/side_servo.stl: camera_aim.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/camera_aim.scad>; rotate([90,0]) side_servo();' \
	output/side_servo.stl

output/side_camera.stl: camera_aim.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/camera_aim.scad>; rotate([0,90]) side_camera();' \
	output/side_camera.stl

output/servo_holder.stl: camera_aim.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/camera_aim.scad>; servo_holder();' \
	output/servo_holder.stl

output/base.stl: camera_aim.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/camera_aim.scad>; base();' \
	output/base.stl
