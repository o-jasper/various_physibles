
default: basic

clean:
	rm output/*.stl

basic: vertslide

#These are all methods, each method seperately contains files relating to that method
# Files including the word `show` are just for visualization.
all: vertslide vertslide_no_guide insert_halfway ringclip

vertslide: output/inner.stl output/outer_half_vertslide.stl output/guide.stl \
	output/vertslide_show.stl \

vertslide_no_guide: output/vertslide_no_guide.stl output/inner.stl

insert_halfway: output/insert_halfway.stl

ringclip: output/ringclip.stl output/outer_half_ringclip.stl  output/inner.stl output/guide.stl

#All files for visualization.
all_show: vertslide_show.stl ringclip_show.stl

output/%.stl: bearing.scad
	sh ../../bin/scad.sh 'use<'`pwd`'/'$<'>;'`echo $@ | cut -f 2 -d/ |cut -f 1 -d.`'();' \
		$@
