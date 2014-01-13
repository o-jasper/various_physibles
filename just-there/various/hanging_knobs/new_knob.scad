//
//  Copyright (C) 25-3-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Feh it sucks.

r = 5;

h=40;
ht=3*h/4;
hm = h/5;

rt=20;
rm = 10;
rb = 30;

screw_ir=4;

inf = 3*h;

module knob_profile()
{
    difference()
    {   minkowski()
        {   union()
            {   polygon([[0,0],[0,hm],[rm,hm], [rb,0]]);
                polygon([[0,hm],[0,h], [rt,ht], [rm,hm]]);
            }
            circle(r);
        }
        square([2*screw_ir,inf],center=true);
    }
}

module knob()
{   rotate_extrude() knob_profile(); }

knob();
