//
//  Copyright (C) 11-04-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Note: only really suitable for mh<t;

use<../lib/rounded_box.scad>

l= 100; //Length of holder.
d= 30;  //Depth of holder.

t= 5;   //Thickness of walls.

mr = 9;   //Radius of embedded magnets.(Get it right!)
mh = t/2; //.. height

h = max(2*mr+t/2, 2*t); //Calculated height

//If there is a 'center thing, you can 'wipe with' (Doesnt seem very useful!)
center_thing=false; 

module magnet_hole()
{   rotate([90,0]) translate([0,h/2,-mh]) cylinder(r=mr,h=2*mh);
}

module bag_holder()
{
    id = d-2.5*t;
    difference()
    {
        linear_extrude(height=h)
        {   if( center_thing ) translate([l/2,d/2]) difference()
            {   square([d,d],center=true);
                translate([d/2,0]) scale([0.4,1]) circle(d/2);
                translate([-d/2,0]) scale([0.4,1]) circle(d/2);
            }
            difference()
            {   rounded_square(l,d, t/2);
                translate([t,t]) rounded_square(l-2*t,d-2*t, t/2);
            }
        }
        translate([-l,t+id/4,h/2]) scale([1,1,2*(h-t)/id])
            rotate([0,90]) cylinder(r= id/4, h=3*l);
        translate([-l,d-(t+id/4),h/2]) scale([1,1,2*(h-t)/id])
            rotate([0,90]) cylinder(r= id/4, h=3*l);
        
        if( !center_thing )
        {   translate([l/2,0]) magnet_hole(); }
        translate([mr+t,0]) magnet_hole();
        translate([l-mr-t,0]) magnet_hole();
    }
}

bag_holder();
