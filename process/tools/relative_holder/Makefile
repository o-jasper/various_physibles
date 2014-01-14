
SCAD=../../../bin/scad

default: edm holder

edm: output/edm_top.stl output/edm_bottom.stl
holder: output/holder_body.stl output/holder_knob.stl output/holder_z_slider.stl \
	output/holder_platform.stl

output/holder_%.stl: holder.scad
	$(SCAD) module $< $@

output/edm_%.stl: edm_holder.scad
	$(SCAD) module $< $@
