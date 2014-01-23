
SCAD=../../../bin/scad

default: edm holder wobble

edm: output/edm_top.stl output/edm_bottom.stl
holder: output/holder_body.stl output/holder_knob.stl output/holder_z_slider.stl \
	output/holder_platform.stl
wobble: output/wobble.stl output/wobble_edm_bottom.stl output/wobble_edm_top.stl \
	output/wobble_spacer.stl

output/holder_%.stl: holder.scad params.scad
	$(SCAD) module $< $@

output/edm_%.stl: edm_holder.scad params.scad
	$(SCAD) module $< $@

output/wobbl%.stl: wobble_edm_holder.scad params.scad
	$(SCAD) module $< $@
