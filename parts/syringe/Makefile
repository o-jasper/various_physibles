
default:scad

all: scad

scad: output/inner_syringe.stl output/outer_syringe.stl

output/inner_syringe.stl: syringe.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/syringe.scad>;inner_syringe();'\
		output/inner_syringe.stl

output/outer_syringe.stl: syringe.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/syringe.scad>;outer_syringe();'\
		output/outer_syringe.stl
