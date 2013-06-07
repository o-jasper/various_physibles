#Would be escad because it can do rounding, but its .stls dont work so well
# at the moment.

default: scad

scad:  output/clamper.scad.stl output/rot_down.scad.stl
escad: output/clamper.stl output/rot_down.stl

output/clamper.stl: inward_clamp.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/inward_clamp.escad>;clamper();' \
		output/clamper.stl

output/rot_down.stl: inward_clamp.escad
	sh ../../bin/escad.sh 'include<'`pwd`'/inward_clamp.escad>;rot_down();' \
		output/rot_down.stl

output/clamper.scad.stl: inward_clamp.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/inward_clamp.escad>;clamper();' \
		output/clamper.scad.stl

output/rot_down.scad.stl: inward_clamp.escad
	sh ../../bin/scad.sh 'use<'`pwd`'/inward_clamp.escad>;rot_down();' \
		output/rot_down.scad.stl
