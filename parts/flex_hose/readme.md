# Flexible hose
They're basically two hollow spheres, except with one has slots in the side so it can
flex to shrink, this makes them easier to fit together with larger allowed tolerances
on size.(easier to print)

Thanks very much to [this](http://www.thingiverse.com/thing:28255), due to
[thingiverse user](http://www.thingiverse.com/Sal/) "Sal" Stefan Langemark

## Instructions
These need to printed hollow(zero infill) with no top or bottom layers, with one perimeter
thickness. With slic3r i used the following:

    slic3r -m --perimeters 1 --top-solid-layers 0 --bottom-solid-layers 0 --fill-density 0 flex_hose.stl flex_hose.stl #(to do two at once)

Fairly sure these are pretty robust in staying working as long they're hollow, 
but probably best to try how two fit before printing many.

Of course, to get tighter(more friction)/looser fits you can use the openscad file
directly `t` controls the extra size for the bottom sphere. Using more perimeters 
should make it tighter too.
