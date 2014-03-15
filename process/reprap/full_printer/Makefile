
default: corners bed pulley

corners: output/corner.stl output/top_motor_corner.stl output/rod_block.stl
bed:     output/bed_holder.stl output/bed_holder_w_motor.stl 
pulley:  output/pulley.stl

output/%.stl: fullp.scad corner.scad params.scad bed.scad pulley.scad
	sh bin/one.sh $< $@

output/pulley.stl: pulley.scad params.scad
	openscad $< -o $@

output/%corner.stl: corner.scad params.scad fits/nema.scad
	sh bin/one.sh $< $@

clean:
	rm output/*.stl
