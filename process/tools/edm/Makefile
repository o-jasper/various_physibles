
SCAD=../../../bin/scad

default: wobble

wobble: output/wobble.stl output/wobble_edm_bottom.stl output/wobble_edm_top.stl \
	output/wobble_spacer.stl

output/wobbl%.stl: wobble_edm_holder.scad params.scad
	$(SCAD) module $< $@
