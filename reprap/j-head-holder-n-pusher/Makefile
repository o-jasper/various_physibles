
default:scad

all: scad

scad: output/jh_pusher.stl output/jh_holder.stl output/jh_holder_quickfit.stl \
	 output/jh_sliver.stl output/jh_plateless_holder.stl

output/jh_pusher.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; pusher();' output/jh_pusher.stl

#NOTE: requires support material.
output/jh_holder.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; dual_holder();' output/jh_holder.stl
#Without any quickfit-like stuff (needs support)
output/jh_plateless_holder.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; single_holder(false);' output/jh_plateless_holder.stl

output/jh_holder_quickfit.stl: j-head-holder-n-pusher.scad #TODO
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; dual_holder(w=100);' output/jh_holder_quickfit.stl

output/jh_sliver.stl: j-head-holder-n-pusher.scad
	../../bin/scad.sh 'use<j-head-holder-n-pusher.scad>; sliver();' output/jh_sliver.stl

