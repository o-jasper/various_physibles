
default:scad

all: scad

scad: output/m_m_0.stl output/f_m_0.stl output/f_m_20.stl output/f_m_40.stl

output/m_m_0.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;m_m_flex(l=0);'\
		output/m_m_0.stl
output/f_m_0.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;f_m_flex(l=0);'\
		output/f_m_0.stl

output/f_m_20.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;f_m_flex(l=20);'\
		output/f_m_20.stl
output/f_m_40.stl: flex_hose.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/flex_hose.scad>;f_m_flex(l=40);'\
		output/f_m_40.stl
