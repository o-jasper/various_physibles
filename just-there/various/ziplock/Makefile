
all: output/zipclamp_base.stl output/zipclamp_attach.stl output/plank_hang.stl

output/zipclamp_base.stl: ziplock_clamp.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/ziplock_clamp.scad>;clamp_base(5,120);' \
		output/zipclamp_base.stl

output/zipclamp_attach.stl: ziplock_clamp.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/ziplock_clamp.scad>;pt=30;clamp_attach(5,120);' \
		output/zipclamp_attach.stl

output/zipclamp_attach_nologo.stl: ziplock_clamp_nologo.scad
	sh ../../bin/scad.sh 'include<'`pwd`'/ziplock_clamp.scad>;pt=30;clamp_attach(5,120,with_logo=false);' \
		output/zipclamp_attach.stl

output/plank_hang.stl: plank_hang.scad
	openscad plank_hang.scad -o output/plank_hang.stl
