
SCAD=../../../bin/scad

default: wire_belt belt_patch

belt_patch: output/belt_patch_oshw.stl output/belt_patch_nothing.stl

wire_belt: output/wire_segment.stl output/wire_bead.stl output/wire_h_arching_segment.stl \
	output/wire_flatback_segment.stl output/wire_flatback_segment_hole.stl \
	output/wire_belt_male.stl output/wire_belt_female.stl

output/wire_%.stl: wire_belt.scad
	$(SCAD) module $< $@

output/belt_patch_%.stl: belt_patch.scad
	$(SCAD) module $< $@
