
default:escad

all: escad scad

escad: output/clamp.stl output/clamp_pair.stl
scad: output/clamp.scad.stl output/clamp_pair.scad.stl

output/clamp.stl: clamp.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/openhw.escad>;include<'`pwd`'/clamp.escad>;half_clamp();' \
		output/clamp.stl

output/clamp_pair.stl: clamp.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/openhw.escad>;include<'`pwd`'/clamp.escad>;union(){ half_clamp();translate([8*t,0])half_clamp();}' \
		output/clamp_pair.stl

output/clamp.scad.stl: clamp.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>;use<'`pwd`'/clamp.escad>;half_clamp();' \
		output/clamp.scad.stl

output/clamp_pair.scad.stl: clamp.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>;use<'`pwd`'/clamp.escad>;half_clamp();translate([8*t,0])half_clamp();' \
		output/clamp_pair.scad.stl
