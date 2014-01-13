
default:scad

all: scad

scad: pill_plug

pill_plug: output/pill_plug.stl output/pill_socket.stl\
	 output/pill_socket_cover.stl output/pill_plug_top_cover.stl

output/pill_%.stl: pill-plug.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2- -d'_' | cut -f 2 -d/ |cut -f 1 -d.`'();'\
	 $@
