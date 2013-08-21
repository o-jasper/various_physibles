//
//  Copyright (C) 01-08-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//One end goes into the hole and the other around the peg that usually is
// used with the hole. Now the two are held together at a different distance.

r = 8.5/2;
t=5;

sl = 8;
l=28;
w= 2*(r+t);

h = 7;
ch = 3;

module profile()
{
    difference()
    {
        union()
        {   square([l,w],center=true);
            translate([l/2,0]) circle(r+t);
            translate([-l/2,0]) scale([sl/(2*(r+t)),1]) circle(r+t);
        }
        translate([l/4,0]) square([l/2,2*r],center=true);
        translate([0,w]) square([2*r,2*w],center=true);
        circle(r);
        
        translate([l/2,0]) circle(r);
    }
}

module pants_holder()
{
    union()
    {   intersection()
        {   linear_extrude(height=2*h) profile();
            difference()
            {   union()
                {   translate([l/4,0]) scale([1,1,0.3]) sphere(l);
                    cube([l,sl*0.7,3*h],center=true);
                }
                translate([l-r,0,h+l]) cube(l*[2,2,2],center=true);
                translate([-r,w,h+l/2]) rotate([90,0,0]) scale([0.7,1,1]) 
                    cylinder(r=l/2,h=3*w);
            }
        }
        translate([-l/2,0]) linear_extrude(height=h+ch) intersection()
        {   scale([1.2,0.7]) circle(sl/2);
            scale([sl/(2*(r+t)),1]) circle(r+t);
        }
        translate([-l/2,0,h+ch]) intersection()
        {   scale([1,1,0.7]) sphere(r+t);
            scale([sl/(2*(r+t)),1]) cylinder(r=r+t,h=h);
        }
    }
}

pants_holder();
