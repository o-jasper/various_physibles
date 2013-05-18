# Flexible hose
They're basically two hollow spheres, except with one has slots in the side so it can
flex to shrink, this makes them easier to fit together with larger allowed tolerances
on size.(easier to print)

They're not actually a hose like for water. There are plainly holes in it. I made it 
with the idea that it'd still move but hold a lightweight camera(/other things) in place.

## Instructions
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
However, these potentially have a weakness at the top and bottom of the neck.
(though maybe i just set the retraction too high)

# Author
[Jasper den Ouden](http://www.ojasper.nl/), inspired very much to
[this](http://www.thingiverse.com/thing:43272), by 
[thingiverse user "Sal"](http://www.thingiverse.com/Sal/) Stefan Langemark.

As usual, [the github](https://github.com/o-jasper/various_physibles) contains 
development versions.

A release is [on thingiverse](http://www.thingiverse.com/thing:90830?save=success).
