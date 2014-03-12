
SCAD=../../../bin/scad

default: output/grid.stl output/gridx2.stl

output/%.stl: grid.scad
	$(SCAD) module $< $@

