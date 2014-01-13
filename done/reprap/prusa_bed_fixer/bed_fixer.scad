//
//  Copyright (C) 09-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Thing to fix the prusa mendel bed. Make sure the head doesnt hit it sideways!
// I suggest you move the endstops to help.
// (And make sure the firmware limitations arent too wide)
//The z-rods have spring in them that might help with collisions a lot too.

sr=1.3;

t=3;
d=20;
w=10;
et=0.1;
st = 6;

module bed_fixer(through=false)
{
    difference()
    {   linear_extrude(height=t + w + d) intersection()
        {   difference(){ circle(w/2+t); circle(sr); }
            square([w+t,w+t], center=true);
        }
        translate([0,0,t+w/2]) cube((w+et)*[1,through ? 8 : 1,1], center=true);
        translate([0,w/2-et+2*d,t+w+st+et-2*d]) cube(4*[d,d,d],center=true);
    }
    
}

module bed_fixer_through() //TODO strengthen it??
{    bed_fixer(through=true); }

rotate([90,0,0]) bed_fixer();
