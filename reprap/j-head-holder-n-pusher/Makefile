
default:scad

all: scad

scad: output/jh_pusher.stl output/jh_holder.stl output/jh_holder_quickfit.stl \
      output/jh_sliver.stl output/jh_plateless_holder.stl

output/%.stl: j-head-holder-n-pusher.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
