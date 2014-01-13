
default: escad

escad: output/clamp_hanger_20.stl output/clamp_hanger_30.stl
scad: output/clamp_hanger_20.scad.stl output/clamp_hanger_30.scad.stl 

all: escad scad

output/clamp_hanger_20.stl: clamp_hanger.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/openhw.escad>; include<'`pwd`'/clamp_hanger.escad>;pt=20;$quality = 200;hanger();' \
		output/clamp_hanger_20.stl

output/clamp_hanger_30.stl: clamp_hanger.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/openhw.escad>; include<'`pwd`'/clamp_hanger.escad>;$quality = 200;pt=30;hanger();' \
		output/clamp_hanger_30.stl

output/clamp_hanger_20.scad.stl: clamp_hanger.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/clamp_hanger.escad>;pt=20;hanger();' \
		output/clamp_hanger_20.scad.stl

output/clamp_hanger_30.scad.stl: clamp_hanger.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/clamp_hanger.escad>;pt=30;hanger();' \
		output/clamp_hanger_30.scad.stl
