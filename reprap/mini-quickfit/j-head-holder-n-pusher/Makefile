
default:scad

all: scad

scad: holder pushers

holder:	output/jh_holder.stl output/jh_holder_quickfit.stl \
	output/jh_sliver.stl output/jh_plateless_holder.stl 


pushers: output/jh_pusher_whole.stl output/jh_pusher_bottom.stl output/jh_pusher_top.stl\
	output/jh_pusher_pincher.stl

output/jh_pusher_%.stl: params.scad jh_pusher.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/'jh_pusher.scad'>;'`echo $@ | cut -f 2 -d/ | cut -f 2- -d_ | cut -f 1 -d.`'();'\
	 $@

output/%.stl: params.scad j_head_holder.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/j_head_holder.scad>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
