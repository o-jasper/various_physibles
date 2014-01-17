
# Various designs
Some of them tested, some not at all. There are some releases on thingiverse.
(releases usually contain `.stl`s with default parameters)

Feedback is very welcome.

There is a bunch of stuff here, i have categorized things as 'basically done',
ongoing 'process' and 'just kept here'. Though i may the latter in particular
and may even change the 'done' things a bit.

### Using
You need to add the `lib/` directory to the list of folders for libraries 
[here are some methods](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries).
For instance you could add it to `OPENSCADPATH`(the openscad version of `PATH`,
a `:`-separated) on linux, with:(in `~/.bashrc`)

    export OPENSCADPATH=path_to_project/various_physibles/lib/:$OPENSCADPATH

### Some of the released stuff
The released entries have readmes with links to release files and more info.
**Under `done/`**.

* Pill connectors as attachment method `parts/pill_connector`(iteration on `parts/flex_hose`)
* Corner mirror stick `tools/corner_mirror/`
* Simple clothing hook `various/new_hook/`
* Plank stuff; simple hook `onplank/plank_hook.scad`, 
  hold rod under plank `onplank/spool_plank/`(for filament rolls),
  hold power supply under plank `reprap/power_supply/power_supply_under_plank.scad`.
* Clamp/'knijper' thing in `tools/clamp`
* Pencil holder `reprap/pencil_holder/`(quickly tag the filament so you can see
  its movement)
* Soldering iron holder `tools/solder/`.(not good enough!)
* Some 'artistic stuff' like a (nonfunctioning)pool-table, recursive trees.

### Other things
* Tried making a twisting/clicky pen for a while, but was frustrating.
  The twisting one openscad+slic3r gave trouble not getting usable gcode.
* Also tried making plugs. The latest iteration being based on the pill
  connector idea. However, it requires much more testing.
* Some simple stuff to connect plates.
* It would be nice to allow adding pictures to surfaces..

# Author, License
Jasper den Ouden currently, feel free to fork/cooperate, attribution is much
appreciated.

Things are licenced under the GPL.
