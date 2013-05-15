
all: output/clamp_hanger_20.stl output/clamp_hanger_30.stl

output/clamp_hanger_20.stl: _clamp_hanger.escad clamp_hanger.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=20;hanger();' \
		output/clamp_hanger_20.stl

output/clamp_hanger_30.stl: _clamp_hanger.escad clamp_hanger.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/openhw.escad>; include<'`pwd`'/_clamp_hanger.escad>;pt=30;hanger();' \
		output/clamp_hanger_30.stl


