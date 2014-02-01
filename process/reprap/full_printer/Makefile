
default: corners bed

corners: output/top_corner.stl output/bottom_motor_corner.stl output/bottom_bare_corner.stl 
bed:     output/bed_holder.stl 

output/%.stl: fullp.scad corner.scad params.scad bed.scad
	sh bin/one.sh $< $@
