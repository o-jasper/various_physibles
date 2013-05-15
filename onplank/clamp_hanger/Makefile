
all: output/clamp_hanger_20.scad.stl output/clamp_hanger_30.scad.stl output/clamp_hanger_20.stl output/clamp_hanger_30.stl

output/clamp_hanger_20.scad.stl: _clamp_hanger.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=20;hanger();' \
		output/clamp_hanger_20.stl

output/clamp_hanger_30.scad.stl: _clamp_hanger.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=30;hanger();' \
		output/clamp_hanger_30.stl

output/clamp_hanger_20.stl: _clamp_hanger.escad
	sh ../../bin/escad.sh '$quality = 40;include<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=20;hanger();' \
		output/clamp_hanger_20.escad.stl

output/clamp_hanger_30.stl: _clamp_hanger.escad
	sh ../../bin/escad.sh '$quality = 40;include<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=30;hanger();' \
		output/clamp_hanger_30.escad.stl


