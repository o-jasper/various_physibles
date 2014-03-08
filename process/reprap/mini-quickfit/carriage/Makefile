SCAD=../../../../bin/scad

default: carriage output/fan_attach.stl

carriage: output/carriage.stl output/rotate_lock.stl output/belt_holder_top.stl


output/fan_%.stl: fan_attach.scad
	$(SCAD) module $< $@

output/%.stl: carriage.scad
	$(SCAD) module $< $@
