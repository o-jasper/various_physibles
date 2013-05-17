
default:scad

all: scad

scad: output/flex_hose.stl

output/flex_hose.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section();'\
		output/flex_hose.stl
