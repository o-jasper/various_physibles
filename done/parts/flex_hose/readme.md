# Flexible hose
They're basically two hollow spheres, except with one has slots in the side so it can
flex to shrink, this makes them easier to fit together with larger allowed tolerances
on size.(easier to print)

They're not actually a hose like for water. There are plainly holes in it. I made it 
with the idea that it'd still move but hold a lightweight camera(/other things) in place.

## Instructions
(see below for use as openscad)
These need to printed hollow(zero infill) with no top or bottom layers, with one perimeter
thickness. With slic3r i used the following:

    slic3r -m --perimeters 1 --top-solid-layers 0 --bottom-solid-layers 0 --fill-density 0 flex_hose.stl flex_hose.stl #(to do two at once)

Fairly sure these are pretty robust in staying working as long they're hollow, 
but probably best to try how two fit before printing many.

Of course, to get tighter(more friction)/looser fits you can use the openscad file
directly `t` controls the extra size for the bottom sphere. Using more perimeters 
should make it tighter too. Note that slic3r has the annoying habit of unifying near
positions sometimes.

To save material per length, you can also add a pole in the middle, 
`flex_hose_pole_20.stl`, `flex_hose_pole_40.stl` for 2cm and 4cm respectively. 

### Tips/tricks
If some end up too loose anyway, you can add some masking tape to the sockets to
make it tighter.

It can still be improved, in my experience, first time popping it in, it still cracks
now and then. These crack can be fixed by heating them up with the hot end, extruding
on it, and finishing it up a bit by using pincers to pinch it a bit while
still hot. Careful, the hot end might burn you! Ensure you dont have to 
look at the computer to make it extrude.(for instance in pronterface by typing 
extrude 2 in the bar and working with it selected, you only hitting return to extrude)

### Reference
These parameters should work everywhere:

`r=10` is the radius of the buildous bit.

`t=0` is the size difference between the male and female.

`n=6` is the number of petals on the male.

#### Modules
`female()` is the female end. Substract it somewhere if you want to make a part connect
using this system. Single-walled PLA females tended to crash, which limits how tight it
can be. However, if your object is really solid, it probably wont have this problem so 
soon, to get a good grip you might want to substract it smaller; `female(t=-1)`.

`male()` is the male end.

#### Sections
Two kinds of sections female to male - `f_m_flex`, and male to male `m_m_flex`.

`l=0` is the length of a section.

`allow_rotate=false;` is whether to put a cap on the female, for the sections,
this is where the male goes in, if it is on an object.

`ln=6` is the number of sides to that. `pk=2` it the kind chosen. Just the one right now.

# Author
[Jasper den Ouden](http://www.ojasper.nl/), inspired very much to
[this](http://www.thingiverse.com/thing:43272), by 
[thingiverse user "Sal"](http://www.thingiverse.com/Sal/) Stefan Langemark.

Locations: [github](https://github.com/o-jasper/various_physibles), 
[fabfabbers](http://www.fabfabbers.com/models/id/134/flex-hose-by-o-jasper) and
[thingiverse](http://www.thingiverse.com/thing:90830?save=success).
