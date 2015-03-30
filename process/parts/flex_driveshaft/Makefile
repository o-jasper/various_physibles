
SCAD=../../../bin/scad

default: output/link_printable.stl output/rod_printable.stl output/plug.stl

output/%.stl: flex_driveshaft.scad
	$(SCAD) module $< $@
