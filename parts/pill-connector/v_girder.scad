//
//  Copyright (C) 03-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<pill.scad>

//$fs=0.5;

r=2.4;
w=20;

module v_profile()
{
    t=2*r;
    s=w/sqrt(2)-r;
    union()
    {
        circle(r);
        translate([0,s]) circle(r);
        translate([s,0]) circle(r);
        translate([-r,0]) square([t,s]);
        translate([0,-r]) square([s,t]);
        difference()
        {   square([t,t]);
            translate([t,t]) circle(r);
        }
    }
}

l=40;
t=1;
module pill_v_beam()
{   s=w/sqrt(2)-r;
    rotate([-90,0,0]) difference()
    {   intersection()
        {   union()
            {   translate([0,-w/4,s-r]) rotate([0,90,0]) linear_extrude(height=l) 
                    rotate(45) v_profile();
                cylinder(r=w/3, h=w/2); //Pills go in here.
                translate([l,0]) cylinder(r=w/3, h=w);
            }
            translate([l/2,0,w/2]) cube([2*l,4*w/7,w], center=true);
        }
        translate([0,0,-t]) pill_sub(t=t);
        translate([0,0,w/2]) scale([1,20,1]) cylinder(r1=w/3,r2=2*w/3,h=w/2);
        translate([l,0]) 
        {   translate([0,0,t]) pill_sub(t=t);
            scale([1,20,1]) cylinder(r2=w/3,r1=2*w/3,h=w/2);
        }
    }
}

//pill_sub(t=t);

//linear_extrude(height=20) v_profile();

pill_v_beam(l=24);
