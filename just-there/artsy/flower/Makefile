
default:scad

scad: output/outer.stl output/inner1.stl \
	output/inners1.stl output/inners2.stl \
	output/center.stl

output/outer.stl: flower.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flower.scad>; outer();' \
	output/outer.stl

output/inner1.stl: flower.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flower.scad>; inner1();' \
	output/inner1.stl

output/inners1.stl: flower.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flower.scad>; inners1();' \
	output/inners1.stl

output/inners2.stl: flower.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flower.scad>; inners2();' \
	output/inners2.stl

output/center.stl: flower.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flower.scad>; center();' \
	output/center.stl
