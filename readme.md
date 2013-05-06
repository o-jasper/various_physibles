
# Various designs
Some of them tested some not at all. There are some releases on thingiverse.
(releases usually contain `.stl`s with default parameters)

I dont do much or any 'artistic' stuff, often focus on stuff that seems 
missing a bit, like pens and plugs.

Feedback is very welcome.

## Highlight: released
The released entries have readmes with links to release files and more info.

* Corner mirror stick `corner_mirror/`
* Simple clothing hook `hooks/new_hook.scad`
* Ziplock bag holder `bag_holder/bag_holder.scad`
* Plank stuff; simple hook `onplank/plank_hook.scad`, 
  hold rod under plank `onplank/spool_plank.scad`, hold power supply under plank
  `reprap/power_supply/power_supply_under_plank.scad`.
* Pencil holder `reprap/pencil_holder/`

## Hightlight: not there yet
Two of these have been held back largely by software issues which kindah sucks..

### Pen
`pen/` Afaik there arent any printable retracting pens yet. I sortah have one but it is
too on and off, and openscad has been a pain!

### Plug
`parts/plug/` the h-plug is ... reasonable however it seems that print lines
perpendicular to motion is a bad idea. Probably a new go with one printed lying
down, and/or clamping by the wires themselves. 

### Screw clamp
Under `screw_clamp/`, should be perfectly fine, seems like slic3r is failing to
make decent gcode for it.

### Platenect
`platenect/` Connects plates, which is pretty easy when you think about it. Idea is
optional cutting off a corner, but otherwise leaving the plates untouched.
A 'back liner' instead of a corner cut might be good additional option.

### Soldering iron holder
`solder/` idea for a soldering iron that uses a tin can(like 500ml beer) for
heat dissipation. Wrote it at a point when i didnt have a printer yet. May be
something to look at again.

# Author, License
Jasper den Ouden currently, feel free to fork/cooperate, attribution is much
appreciated.

Things are licenced under the GPL.
