
default:scad

all: scad

scad: output/carriage.stl output/rotate_lock.stl output/belt_holder_top.stl

output/carriage.stl: carriage.scad
	../../bin/scad.sh 'use<carriage.scad>; carriage();' output/carriage.stl

output/rotate_lock.stl: carriage.scad
	../../bin/scad.sh 'use<carriage.scad>; rotate_lock();' output/rotate_lock.stl

output/belt_holder_top.stl: carriage.scad
	../../bin/scad.sh 'use<carriage.scad>; belt_holder_top();' \
	output/belt_holder_top.stl

