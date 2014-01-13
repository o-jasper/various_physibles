#Would be escad because it can do rounding, but its .stls dont work so well
# at the moment.

default: scad

scad:  output/damper.stl output/tie_rib_clamp.stl

output/damper.stl: foot.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/foot.scad>;damper();' \
		output/damper.stl

output/tie_rib_clamp.stl: foot.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/foot.scad>;tie_rib_clamp();' \
		output/tie_rib_clamp.stl
