
default:escad

all: escad scad

escad: output/clamp_pair.stl
scad: output/clamp_pair.scad.stl

output/clamp_pair.stl: clamp.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/openhw.escad>;include<'`pwd`'/clamp.escad>;union(){ half_clamp();clamp_pair();}' \
		output/clamp_pair.stl

output/clamp_pair.scad.stl: clamp.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>;use<'`pwd`'/clamp.escad>;clamp_pair();' \
		output/clamp_pair.scad.stl
