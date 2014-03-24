# Full design of body of 3d printer
WIP mostly an idea, and quite possible i'll never actually make it.

So far largely inspired on Ultimaker design, bit on the wally.
(though the arm has terrible mechanical advantage, i will likely not use it)

Initially the idea is to have a plate-based design, minimize the weight of XY 
moving bits, and have a hole entirely from the side. But then came the idea of
putting the z-sliding bits in the corners, and i like this better.

## TODO
* Figure out a lightweight x-slider..
* Adding/removing the Y-rods to the assembled machine should be easier.
  (now they basically need to be added before fixing the plates.)
* The *entire* motion part..
* Damping feet?(probably add rubber)
* Note: 'T-rail' for curtains is elsewhere, they could be made to fit planks in
  general and this thing in particular.

### Info

#### Stretch in wires
What is the young modulus of the wire? (see 5.1×10^9 N/m^2, but its an exercise).
If it is really good i can put motors near the floor. 

~2m long, ~25mm^2 =25e-6m^2 F=Yd/AL => d/F = AL/Y = 25e-6 x 2 /5e9 = 10e-3 m/N = 1mm/N
(ballpark)

#### Torque
See a holding torque of 47.1Ncm,
The platform.. well lets say at least need to be able to deal with 3kg, (30N)

# Design

## Bed lifting
~3cm spool rolling up going up and down from the bed platform twice, giving a 4x
mechanical advantage.

Big disadvantage is that it doesnt 'lock' itself when the motor is off..

## XY
Relatively heavy 8mm dia Y bars, go light for the carriage and X bars.(those move)
Might want an smallish aluminium extruded profile for that? 
(Wait what about those curtain rails [still being made](https://www.gamma.nl/assortiment/intensions-practical-basic-rail-flexrail-wit/p/B933508?q=fh_location%3d%2f%2fcatalog01%2fnl_NL%2f%24s%3drail%2ffh_item_type%3d{product}%26fh_eds%3d%25C3%259F%26fh_lister_pos%3d13%26fh_refview%3dsearch%26fh_secondid%3db_product_b021933508) Okey, that *is* a little crazy, no idea if it is up to it.)

### Putting the torque trough the smooth rods
Thats an idea, the effective mass is I/R^2 with the radius of the pulley. Lets say
that is 2cm, I for a 1m 1cm diameter smooth rod 


I = πρLR^4 /2 ~ 1.5\*(8\*10^3 kg/^3 )\*1m\*(0.5\*10^-2 m)^4 = 1.6\*10^-5 kgm^2

m\_effective = I/R^2 = I/2\*10^-2 m = 7\*10^-4 kg = 0.7g

Seems ridiculously good...

# Design: left behind(ish)

## Bed lifting.

### Option: Threaded rod
Advantage is that it blocks movement when the motor is off, but i dont like it.
Could be put parallel to the smooth rod and have a similar setup as a prusa.

### Option straight lift
It could be geared to deal with the torque, w/o smaller than 1cm(thats too small)
The winding radius of like 3cm is nicer, then give it a 4x torque advantage.

The best option is i think to run the line up and down twice, and put the motor 
under the ned, that would get the 4x mechanical advantage.

**Suboption: gears** want the big gear to be easily printable? ~12cm and 3cm total 
15cm can fit horizontally under the bed probably best. Otherwise i dont know where
to put it.. Multiple stages, like x2x2 could be smaller, but..

**Suboption: worm gear** 

### Option arm
Basically an arm that pushes it up. Left behind for the lack of mechanical
advantage. Thinking of using an arm anyway..

**Suboption: nylon wire pull**: current design idea. Have calculation for 
mechanical advantage on paper. Looks like it needs much more mechanical advantage?

**Suboption: motor on arm**: Basically give the wheeled arm teeth and use a worm
gear. Even more force on the threads than the other one..
