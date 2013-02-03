
# Soldering iron holder
Uses a long tin can to protect the PLA/ABS from the hot end. 
The expectation is that that will provide enough heat conduction to prevent any
melting/fire. Currently untested and, no guarantees on this!

It *might* be printable as two pieces.

### TODO
* Make the top screw into the holder? More stuff for holding the top in place?
* `holder front` can have a thing that can hold the top side outside the can.
* Attachments:(like previously)
 + optional extendable feet
 + holes for screws to attach it to
 + there is space for weight, maybe any kinds of weight to aim for?
* Printing it.. (one day)
* List parameters.
* Check parameter range. gifs of the thing changing through them would be nice for
  presentation.

# Parameters:
Note that there really aught to be a system to very standardly list them, i am
sure many useful features follow, like guis to set them, automatically making 
the models at different parameters.

Non-comprehensively, more parameters are commented in the file.
Parameters attempt to take reasonable values. Basically expect reasonable results
if the values that are set are reasonable.
(but the range of possibilities is large so might have bad ones)

Of course the default parameters aim at a particular 
`can_r,can_h,can_tx,can_ty=33,167,10,10`

`can_a`: Angle of the can. And thus the soldering iron. Can do 0&deg;-90&deg;,
only really reasonable 10&deg;-80&deg;

`can_r`: Radius of the can.

`can_h`: Height of the can.
`can_t`: Taper of the can.

`can_sheeth_w`: If worry about the can buckling, encapsulate it by making this 
                value `>0`, the width of the sheeth you want.

`plate_w`: Thickness of the supporthing structure.

`pillar_r`: Thickness radius the pillars.(default `plate_w*0.7`)

`base_front_w`: Size of the front.(overrides the below)

`base_square_p`: Sets `base_front_w` to make the base square.(overrides the below)

`base_min_front_p`: Makes `base_front_w` as small as reasonable.

`base_h`: height of the base, if `<0`, base is omitted.

`base_wall_h`: if `>0` a little wall makes for a cup to throw stuff in.

`base_wall_w`: Base wall thickness defaults `plate_w/3`

`single_p`: If true, a single column holds it up, otherwise a single column splits.

`base_back_p`: whether to have a base(possibly with cup) at the back.
