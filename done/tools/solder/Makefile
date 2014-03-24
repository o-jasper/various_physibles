
SCAD=../../../bin/scad

default: scad

scad: output/bottom_end.stl output/holding_ring.stl output/can_top.stl output/stand.stl

output/%.stl: solder.scad
	$(SCAD) module $< $@
