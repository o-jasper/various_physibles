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

cl= 260; //circumference.

pi=3.14;
r= cl/(2+pi);

echo(2*r);

t= 7;   //Thickness of walls.

mr = 9;   //Radius of embedded magnets.(Get it right!)
mh = t; //.. height

h = max(2*mr+t/2, 2*t); //Calculated height

inf=2*(h+r);

module magnet_hole()
{   rotate([90,0]) translate([0,h/2,-mh]) cylinder(r=mr,h=2*mh);
}
module bag_holder()
{
    difference()
    {   intersection()
        {   scale([1,1,h/t]) translate([0,0,t/3]) union()
            {   scale([1,1,1]) rotate_extrude()
                    translate([r-t/2,0]) circle(2*t/3);
                translate([t/3-r,0]) rotate([0,90]) cylinder(r=2*t/3, h=2*(r-t/3));
            }
            scale([1,1,h/t]) translate([0,inf,inf]) cube(2*[inf,inf,inf], center=true);
        }
        magnet_hole();
    }
}

bag_holder();
