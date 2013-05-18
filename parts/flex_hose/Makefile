
default:scad

all: scad

scad: output/flex_hose.stl output/flex_hose_loose.stl flex_hose_pole_30.stl output/flex_hose_loose.stl flex_hose_pole_40.stl

output/flex_hose.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section();'\
		output/flex_hose.stl
output/flex_hose_2.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section_set(2,1);' \
		output/flex_hose_2.stl
output/flex_hose_9.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section_set(3,3);' \
		output/flex_hose_9.stl

output/flex_hose_loose.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section(0,0.5);'\
		output/flex_hose_loose.stl

output/flex_hose_pole_20.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section(20);'\
		output/flex_hose_loose.stl
output/flex_hose_pole_40.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;section(20);'\
		output/flex_hose_loose.stl
