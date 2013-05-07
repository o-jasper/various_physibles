
# Clamp based on screw
The existing screw based clamps didnt quite suit me, so i made another one.
Then I didnt like all the support material needed, so then yet another one.

The defaults here -also used for the .stls- are for a M6 x 60mm bolt. The 
parameters in the .scad file should be clear.

## Instructions
Make sure you have a >60mm M6 bolt, or see the parameters section.

Print `thumb_wheel.stl`, `rodend.stl` and `screw_clamp.stl`.
(or `screw_clamp_flying.stl`, but it'll require support.)

## Parameters
If you want another bolt, you have to set some parameters in the `screw_clamp.scad`
file, defaultly:(all values in millimeters)

    //M6 x 60
    l = 60; //Length of bolt.
    br = 6/2; //Radius of bolt.
    
    nw = 10.8; // Nut width
    nh = 6; //Nut height.
    hh = 5; //Head height.

    hl = 30; //Handle length.(minimum of 1.1*hh+ti)
        
    t=5; //Thickneses of some walls,

Dont confuse radii with diameters. You can of course also use the default values
and use this to check you actually have the right size.

# Author
[Jasper den Ouden](http://ojasper.nl/), put under a GPL license. Attribution and
feedback is appreciated.
