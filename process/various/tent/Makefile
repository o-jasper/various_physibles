
SCAD=../../../bin/scad

default: tiny_corners

tiny_corners: output/tiny_top_corner.stl output/tiny_bottom_corner.stl 

output/%.stl: squaretop.scad
	$(SCAD) module $< $@
