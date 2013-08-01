
default: output/pants_holder.stl

output/pants_holder.stl: pants_holder.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/pants_holder.scad>; rotate([90,0,0]) pants_holder();' \
	output/pants_holder.stl
