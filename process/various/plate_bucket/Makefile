
default:scad

scad: output/bottom_section.stl output/floor_section.stl output/corner_section.stl \
 output/bottom.stl output/floor.stl

output/bottom_section.stl: sectioned_plate_bucket.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/sectioned_plate_bucket.scad>; bottom_section();' \
	output/bottom_section.stl

output/floor_section.stl: sectioned_plate_bucket.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/sectioned_plate_bucket.scad>; floor_section();' \
	output/floor_section.stl

output/corner_section.stl: sectioned_plate_bucket.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/sectioned_plate_bucket.scad>; corner_section();' \
	output/corner_section.stl

output/bottom.stl: plate_bucket.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/plate_bucket.scad>; bottom();' \
	output/bottom.stl

output/top.stl: plate_bucket.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/plate_bucket.scad>; top();' \
	output/top.stl
