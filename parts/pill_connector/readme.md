# Expanding cylinder attachment strategy
Need to connect two parts semi-permanently? This might be the thing to use,
Just substract `pill_sub()`(`pill_sub.stl`) on the two parts to connect, 
compress, and pop the 'cylinder pill'(`fat_pill` if you want it to be tighter)
in, and then pop the other part on that.

This entry contains the pill and `pill_sub` as development aid.

## Instructions
The pills need to be printed with zero infill, zero bottom and top layers,
and one perimeter.(at ~0.5mm, if you lay out a particularly small perimeter,
you may want more)

Pills are used on designs by substracting `pill_sub` halfway at places on 
the two parts in such a way they line up the way you want them.

The beams are not intended to hold an angle by themselves. They're mostly an
illustration on how to use them at the moment.

## Discussion
It is inspired on my earlier 
[flex_hose](http://www.fabfabbers.com/models/id/134/flex-hose-by-o-jasper). 
As opposed to that, it
rotates one way as to eliminate it popping out after rotating beyond the
allowed range. Use two in sequence for more motion and two in parallel
to hold something.

The flex hose was hoped to be usable as an arm that you set at some location
and it will stay there. There is a 'beam' in the files here with which i was
hoping the same for. Although it is better, i do not think it succeeds. 

So far i have been trying continuous rotation, maybe an approach looking for
discrete rotation will do better.

### Wall shape
I tried to design the walls inside to take a path maximizing how far it can
decrease in size and still have a decent force to expand itself, while not
having the walls attach to each other too much during print. Since i want 
to have the ring in the middle, and round the top and bottom the distance to the 
outer walls is more important than distances between inner walls.

Formalizing these requirements more, i reckon this might be something to try
optimize using a computer.

## Author
Jasper den Ouden, licensed under the GPLv3

Place of development is currently
[github](https://github.com/o-jasper/various_physibles).

Released on [thingiverse](http://www.thingiverse.com/thing:98953) and
[fabfabbers](http://www.fabfabbers.com/models/id/168/pill-connector-by-o-jasper).
