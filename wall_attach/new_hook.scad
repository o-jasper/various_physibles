//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

wall_r= 15;
hook_r= 10;

R=100;
a=60;
h=100;

a_b = 30;

s=0.7;

d=100;

module hook_part()
{
    r = hook_r;
    d= R+2*r;
    difference()
    {   rotate_extrude() translate([R,0]) circle(r);
        rotate(a = 90-a) translate([0,-2*d]) cube(4*d*[1,1,1], center=true);
        translate([-2*d,0]) cube(4*d*[1,1,1], center=true);
    }
   
    rotate(a = 90-a) translate([R,0]) sphere(r);
}

module hook()
{
    r = wall_r;
    difference()
    {   union()
        {   translate([0,-R]) scale([s,1]) 
            {   rotate([0,a_b]) hook_part();
                rotate([0,-a_b]) hook_part();
            }
            rotate([90,0]) cylinder(r=r,h=h-3*r);
            translate([0,3*r-h]) scale([1,2]) sphere(r);
            sphere(r);
        }
        translate([-2*h,0,0]) cube(4*h*[1,1,1], center=true);
    }
}

hook();

