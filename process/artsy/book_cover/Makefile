
SCAD=../../../bin/scad

default: output/book_back.stl output/book_front.stl output/book_spine.stl 

output/%.stl: book_cover.scad
	$(SCAD) module $< $@
output/book_back.stl: book_cover.scad output/back.dat
	$(SCAD) module $< $@
output/book_front.stl: book_cover.scad output/front.dat
	$(SCAD) module $< $@

output/%.png: %.svg Makefile
	convert -negate -resize 20% $< $@
output/%.dat: output/%.png
	../../../bin/img2dat/img2dat $< gray.dat > $@
