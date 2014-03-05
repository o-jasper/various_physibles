
SCAD=../../../bin/scad

default: oneway_rubber pump_rubber

oneway_rubber: output/rubber_oneway_lone.stl output/rubber_oneway_lone_cover.stl
pump_rubber: output/pump.stl output/plunger.stl output/cover.stl

plunger_fancy: output/plunger_fancy.stl #Not manifold :/

output/rubber_%.stl: oneway_rubber.scad
	$(SCAD) module $< $@

output/%.stl: pump_rubber.scad oneway_rubber.scad
	$(SCAD) module $< $@

