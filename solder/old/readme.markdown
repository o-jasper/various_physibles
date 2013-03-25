
## Soldering iron holder
Soldering iron using metal sheets to protect ABS/PLA from the hot end, and
using ten metal rods to(hopefully) hold the hot end in the air.

Note that it may be a fire hazzard, or *at least* ABS can fume if the solder 
touches it etcetera, continue at your own risk.

One big TODO about this is to 'cut it up' for actualy printing, also since otherwise you cant 
really fit the sheets in.

The default is overkill, turn either `expanding_base_p` or `screwable_p` off, or both.

### Material-like parameters
`plate_w`: width you like walls to be.</br />
`sheet_w`: width of sheet material.

### Object parameters

`holder_l`,`holder_h`: length of sheet and depth it is clamped.
TODO `holder_l` vs `room_l` and clear on length of sheet.
TODO `holder_h` not robust.

`solder_hold_w`, `solder_hold_l`: width and length of solder holder part.

`room_w`, `room_l`: room where the soldering iron is supposed to ~ freely
float.

`holder_angle`: angle at which the iron is held.

`holder_base_l`: how long in the `y` direction the 'stem' to the base is.
(not very robust on this)</br />
`holder_base_h`: how thick the basic base is.</br />
`holder_base_r`: Rounding on the edges of the base.

`holding_bar_r`: size of the bars that are supposed to hold the iron.

#### Optionals
`holder_bin_h`: if `>0`, adds a wall ontop of the bin to possibly throw 
little things in.

`expanding_base_p`: adds two rotatable plates at the bottom that can be 
moved to make the base wider. This base is added onto the regular base.

`screwable_p`, `screw_w`, `screw_r`: if extensions with holes are added to the
side for the purpose of bolting the soldering iron down. Could in principle
also be used simply to widen the base.
(doesnt make sense to combine with expanding base)

### TODO

* It will probably need to be optionally cut up to fit in build areas.

* Separate params file.

* Favorable default parameters and try it.

* List the parameters.(better)

* Insufficient indication that it can hold it, maybe redesign that part.

* Parameter robustness?

* Attachable surfaces.

* Optional handle.

* Optional static base-windener/alternative screw system.

### 2.5d version..
Last version at c5d3f0dafb1af8ffeff528535ce00ad85af4edbf
