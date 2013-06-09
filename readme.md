
# Various designs
Some of them tested, some not at all. There are some releases on thingiverse.
(releases usually contain `.stl`s with default parameters)

Feedback is very welcome.

Since there is so much stuff here, a lot of it sidelines, i highlight the better/more
interesting stuff.

## Highlight: released
The released entries have readmes with links to release files and more info.

* Pill connectors as attachment method `parts/pill_connector`(iteration on `parts/flex_hose`)
* Corner mirror stick `tools/corner_mirror/`
* Simple clothing hook `hooks/new_hook/`
* Plank stuff; simple hook `onplank/plank_hook.scad`, 
  hold rod under plank `onplank/spool_plank.scad`, hold power supply under plank
  `reprap/power_supply/power_supply_under_plank.scad`.
* Pencil holder `reprap/pencil_holder/`(quickly tag the filament so you can see
  its movement)

## Hightlight: not there yet
Two of these have been held back largely by software issues which kindah sucks..

### Soldering iron holder
`solder/` idea for a soldering iron that uses a tin can(like 500ml beer) for
heat dissipation. The olde version i Wrote it at a point when i didnt have a printer
yet. I looked at it again, redesigned, and now have a printed version.

However it still requires work especially at the mouth and holding the soldering iron;
i think the outside will be too hot if the soldering iron touches it.

It was designed to have metal wires running through it, but in practice that
seems a bit hard to actually do. Also the metal can seems veritably enormous for the
task.

It is a WIP. Also note it needs something to hold it down.

### Pen
`pen/` Afaik there arent any printable retracting pens yet. I sortah have one but it is
too on and off, and openscad has been a pain!

### Plug
`parts/plug/` the h-plug is ... reasonable however it seems that print lines
perpendicular to motion is a bad idea. Probably a new go with one printed lying
down, and/or clamping by the wires themselves. 

I think i might try having the clamping action done by the wire itself next.

### Platenect
`platenect/` Connects plates, which is pretty easy when you think about it. Idea is
optional cutting off a corner, but otherwise leaving the plates untouched.
A 'back liner' instead of a corner cut might be good additional option. 
There is no particular problem, i havent tried it yet.

(Also a bunch of stuff already exists out there online)

### Endstop
`reprap/endstop` the idea was a endstop of a higher different height that could
be added/removed without affecting calibration much. However current design is 
much too wobbly. I think a next attempt will just clamp to the smooth z-rod and
be pushed down on whatever below it to keep the distance ~constant.

### Geared hand drill
WIP also. `tools/drill`.

# Author, License
Jasper den Ouden currently, feel free to fork/cooperate, attribution is much
appreciated.

Things are licenced under the GPL.
