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

pi=3.141592653589793;
r= cl/(2+pi);

echo(2*r);

fd = 25; //Distance between 'feature-adding holes'
fr = 2;

t= 6;   //Thickness of walls.

mr = 9;   //Radius of embedded magnets.(Get it right!)
mh = t; //.. height

h = max(2*mr+t/2, 2*t); //Calculated height

inf=2*(h+r);

skimmer=true;

module magnet_hole()
{   rotate([90,0]) translate([0,h/2,-mh]) cylinder(r=mr,h=2*mh); }

module feature_hole()
{
    translate([0,r-t/2]) cylinder(r=fr, h=3*h);
//    translate([0,r-2*t,h+1.2*t]) rotate([-90,0]) 
//        scale([1/8,h/(4*fd)]) cylinder(r=fd, h=3*h);
}

module bag_holder()
{

//2*r^2 *(1-cos(da)) = fd^2
// 1-cos(da) = (fd/r)^2/2
    da = acos(1-fd*fd/(2*r*r));
    intersection()
    {   difference()
        {   translate([0,0,t/3]) union()
            {   rotate([-90,0]) translate([0,t/3-h/2]) cylinder(r=mr+t/2,h=t);
                translate([0,t/2,h/2-t/3])
                {   rotate([0,-45]) translate([mr,0,-sqrt(2)*h]) 
                        cylinder(r=t/2,h=sqrt(2)*h);
                    rotate([0,225]) translate([mr,0]) 
                        cylinder(r=t/2,h=sqrt(2)*h);
                }
                translate([t/2-r,0]) rotate([0,90])  
                    scale([1,3/2]) cylinder(r=2*t/3,h=2*r-t);
                rotate_extrude() translate([r-t/2,0]) circle(2*t/3);
            }
            magnet_hole();
            if( fr>0 ) translate([0,0,-h]) for( a=[0 : da/2 : 80] )
            {   rotate(-a) feature_hole();
                rotate(+a) feature_hole();
            }
        }
        translate([0,inf,inf]) cube(2*[inf,inf,inf], center=true);
    }
}

bag_holder();
