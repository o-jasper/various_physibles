
# Various designs
Some of them tested, some not at all. There are some releases on thingiverse.
(releases usually contain `.stl`s with default parameters)

I dont do much or any 'artistic' stuff, often focus on stuff that seems 
missing a bit, like pens and plugs.

Feedback is very welcome.

Since there is so much stuff here, the following indicates some stuff to maybe 
look at:

## Highlight: released
The released entries have readmes with links to release files and more info.

* Flexible hose for setting things at postions `parts/flex_hose/`.
* Corner mirror stick `tools/corner_mirror/`
* Simple clothing hook `hooks/new_hook.scad`
* Ziplock bag holder `bag_holbder/bag_holder.scad`
* Plank stuff; simple hook `onplank/plank_hook.scad`, 
  hold rod under plank `onplank/spool_plank.scad`, hold power supply under plank
  `reprap/power_supply/power_supply_under_plank.scad`.
* Pencil holder `reprap/pencil_holder/`(quickly tag the filament so you can see
  its movement)

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
There is no particular problem, i havent tried it yet.

### Soldering iron holder
`solder/` idea for a soldering iron that uses a tin can(like 500ml beer) for
heat dissipation. Wrote it at a point when i didnt have a printer yet. May be
something to look at again.

### Endstop
`reprap/endstop` the idea was a endstop of a higher different height that could
be added/removed without affecting calibration much. However current design is 
much too wobbly. I think a next attempt will just clamp to the smooth z-rod and
be pushed down on whatever below it to keep the distance ~constant.


## Hightlight: didnt do anything about it but want
Why not say it.

* Very general drill bit holder, i dont like the existing one, what about a
  bunch of prongs that are pushed together with a thread and a rotating thingy 
  for it. Could even open the back so 'jewellers' screwdrivers(those tiny ones)
  can fit.
  
* Geared hand drill?

# Author, License
Jasper den Ouden currently, feel free to fork/cooperate, attribution is much
appreciated.

Things are licenced under the GPL.
