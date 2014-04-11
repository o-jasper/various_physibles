
SCAD=../../../bin/scad

default: shower_glas_hook

shower_glas_hook: output/shower_glas_hook.stl

output/%.stl: wire_belt.scad
	$(SCAD) module $< $@
