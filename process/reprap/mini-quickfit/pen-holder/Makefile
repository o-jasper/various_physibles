
default: recommend

recommend: output/mqf_syringe_n_slider.stl \
	output/spring_holder.stl output/pen_holder.stl output/filament_holder.stl

other:  output/mqf_double_slider.stl 

output/%.stl: pen_holder.scad
	sh ../../../bin/scad.sh 'use<'`pwd`'/pen_holder.scad>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
