
default:scad

all: scad

scad: output/jh_pusher.stl output/jh_holder.stl output/jh_sliver.stl

output/jh_pusher.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; pusher();' output/jh_pusher.stl

#NOTE: requires support material.
output/jh_holder.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; rotate([0,-90,0]) holder();' output/jh_holder.stl

output/jh_sliver.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; sliver();' output/jh_sliver.stl

