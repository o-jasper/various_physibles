
SCAD=../../../../bin/scad

default:scad

all: scad

scad: holder pushers pushers_3mm

holder:	output/jh_holder.stl output/jh_holder_quickfit.stl \
	output/jh_sliver.stl output/jh_plateless_holder.stl 

pushers: output/jh_pusher_bottom.stl output/jh_pusher_top.stl

pushers_3mm: output/jh_pusher_bottom_3mm.stl output/jh_pusher_top_3mm.stl

output/jh_pusher_%.stl: jh_pusher.scad params.scad 
	$(SCAD) module $< $@

output/%.stl: j_head_holder.scad params.scad 
	$(SCAD) module $< $@
