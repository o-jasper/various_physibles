
default: corners bed

corners: output/zrod_tcorner.stl output/zrod_bcorner.stl output/corner.stl output/xrod_corner.stl
bed:     output/bed_holder.stl 

output/%.stl: fullp.scad corner.scad params.scad bed.scad
	sh bin/one.sh $< $@
