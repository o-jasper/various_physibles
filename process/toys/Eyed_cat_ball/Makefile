
SCAD=../../../bin/scad

default: output/eyed_cat_ball.stl

output/%.stl: eyed_cat_ball.scad
	$(SCAD) module $< $@
