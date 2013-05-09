# Stuff that slides onto planks

* `spool_plank/` holds horizontal rod under plank.

* `plank_hook/` plain hook-kindah thing for under plank.

* `clamp_hanger/` puts a clamp under a plank, i use it to hold stuff i can 
  read without taking space on the table.

* TODO is a wedge so you can overdo the thickess and only need another wedge if
  you have another plank.

## Parameters
In order of importance:

`pt` is the plank thickness.

`pl` is the plank length.

`wd` is the distance from the wall.(some may go between the wall and plank)

`gl` is how far it slides onto the plank.

`t` is typically the thickness around the plank. Other thicknesses may relate to
 it.

`sw` is a square hole vertically through the clamp. It is there so wedges can
have an pin so they cant move. Currently only `clamp_hanger/` has one.

## TODO
Makefiles, how do you change the defaults temporarily easily??
