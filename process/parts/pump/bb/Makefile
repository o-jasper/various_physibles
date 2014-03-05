
SCAD=../../../../bin/scad

default: bb

#TODO it didnt work as it was, the rubber bad seemed much more effective.
bb: output/bb_pump.stl output/bb_plunger.stl output/bb_slide_over.stl 

output/bb_%.stl: pump.scad oneway.scad
	$(SCAD) module $< $@
