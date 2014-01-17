
SCAD=../../../bin/scad

default: wire_belt

wire_belt: output/wire_segment.stl output/wire_bead.stl output/wire_h_arching_segment.stl \
	output/wire_flatback_segment.stl \
	output/wire_belt_male.stl output/wire_belt_female.stl

output/wire_%.stl: wire_belt.scad
	$(SCAD) module $< $@
