
SCAD=../../../bin/scad

default: holder

holder: output/holder_body.stl output/holder_knob.stl output/holder_z_slider.stl \
	output/holder_platform.stl

output/holder_%.stl: holder.scad params.scad
	$(SCAD) module $< $@
