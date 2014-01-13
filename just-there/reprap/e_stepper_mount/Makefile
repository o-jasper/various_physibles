
default: escad

all: escad scad

escad: output/e_stepper_mount.stl
scad:  output/e_stepper_mount.scad.stl

output/e_stepper_mount.stl: e_stepper_mount.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/e_stepper_mount.escad>; thing();'\
		output/e_stepper_mount.stl

output/e_stepper_mount.scad.stl: e_stepper_mount.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/e_stepper_mount.escad>; thing();'\
		output/e_stepper_mount.scad.stl
