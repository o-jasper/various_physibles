#NOTE
# * probably mostly implicitCAD compatible.
# * doesnt use modules for items yet..

SCAD=../../../bin/scad

default: clamp

clamp: output/clamp_female.stl output/clamp_male.stl output/plastic_spring.stl

output/%.stl: clamp.scad
	$(SCAD) module $< $@

