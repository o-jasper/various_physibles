
SCAD=../../../bin/scad

default: rider leeway

rider:  output/hanger.stl output/wheel.stl output/hanger_plain.stl
leeway: output/leeway_spacer_plain.stl output/leeway_spacer_prettify.stl

output/leeway_%.stl: leeway.scad
	$(SCAD) module $< $@

output/hanger.stl: rider.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/rider.scad>; rotate([0,-90,0]) hanger();' $@

output/%.stl: rider.scad
	$(SCAD) module $< $@
