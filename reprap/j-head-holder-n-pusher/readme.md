
# J head pfte tube for 1.75 holder

**NOTE** out of date, the tape slips. The design has been modified to use a 
small bit held back on the pfte itself instead, but the text below isnt updated.
Also the design has been updated since then to fix some size-of-the-j-head 
mistakes, but that hasnt been tested.

Uses two screws and nuts to hold in a pfte tube into the 
[j-head extruder](http://reprap.org/wiki/J-head#Introduction) possibly 
in a bowden configuration.(though the bowden tube can be arbitrarily short)
Has a small 'quick-fit' like form factor, quick fits basically attach to a block,
the size of `jh_holder.stl` is `[80,40,5]mm` 

TODO another .stl for Richraps quickfit, see `[100,28,5]`, think just `+20cm, then.

NOTE: WIP(work in progress)

### Requirements

* (assembled)J-head (compatible)hot end.

* PFTE tube for 1.75mm filament (The outer diameter of mine was 4mm, i have
heard 1/4''.) (TODO make .stl for both)

* m3 screws of sufficient length.

* Something to widen the PFTE tube, tape could be good. Or something just larger 
  than the tube to hold on to it. Need as much adhesion as possible.

### Instructions

The PFTE tube has to push the top of the metal part of the hot end. 
The point is that half-molten plastic there could cause too much friction,
so there shouldnt be room for it.

So widening has to be far enough from that area so it doesnt hit the PEEK and
push on that instead.

**How to make the widening on the pfte tube**: One way to to put a lot of tape
and 'bunch it up' however, it might loosen the tape quite easily! Try get at much 
adhesion. (Dont get the sticky side dirty like for instance with your fingers)

Another way is to use a small length of pfte tube for 3mm filament, drill out to
4mm(better do it by hand!) and push that over the smaller pfte tube, and then
bunch up tape on that.(can also try a bit of glue in this case and it
should be tighter right before the tape, thats the advantage)

You might also want to taper the bottom of the pfte tube at ~30 degree.
(short use of pencil sharpened is okey)

**Print parts**, the sliver is optional, and could be improvised/cut from something,
but it is not much so maybe better to do it. The holder probably needs the first
45mm supported. (`slic3r --support-material-enforce-layers 30 jh_holder.stl` for me
with 0.3mm layer height)

**Get the j-head**, slide into the holder with the hold end in the direction of the 
nut holes. Put the pfte tube with widening in, then put the pusher over the pfte 
tube from the top. Get two screws, washers and nuts, put screws and corresponding 
washes through the top of the pusher. Then through the corresponding holes in the 
holder. The screws should then meet the nuts in the holes for the nuts.

**Push** now it should all be set up to push down. Tighten it, can probably go
pretty far without doing damage, but dont go too far.

Pushing it down will also push it the j-head into the indentation to help keep it 
in place.

If the J-head was used before and plastic accumulated, you might want to tighten 
the screws while the hot end is hot.(carefull, the hot end is hot) The plastic might
then emerge from the nozzle. (depending on if there is space in there)

**Attach** it like a quickfit.(or use your own method)
