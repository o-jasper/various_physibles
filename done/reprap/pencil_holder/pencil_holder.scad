//
//  Copyright (C) 14-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

module clamp(r,t,sr)
{
    w= r+2*(t+2*sr);
    h= sr+2*t;
    difference()
    {   linear_extrude(height= h) difference()
        {   union()
            {   circle(r+t);
                translate([-w,-3*t/2]) square([w + sr,3*t]);
            }
            circle(r);
            translate([-2*w,-t/2]) square([2*w + sr,t]);
        }
        translate([sr+t-w,w,h/2])  rotate([90,0]) cylinder(r=sr,h=3*w);
    }
}

module handy_clamp_leg(r,fr)
{   translate([r,0]) square([t,fr]);
    translate([r+t,fr-t]) circle(t);

    square([r+t,r+t]);
}

//Clamp for hand opening
module handy_clamp_profile(r,t,fr,a)
{
    difference()
    {   union()
        {   circle(r+t);
            rotate(a) handy_clamp_leg(r,fr);
            scale([1,-1]) rotate(a) handy_clamp_leg(r,fr);
        }
        translate([r+t/2,0]) square([2*r,r], center=true);
        circle(r);
    }
}

pr = 4; //Smaller-than-pencil radius.
fr = 15;  //Grabable thing radius.
a=80;     //Angle of grabable thing.
d = 20;   //Distance to mendel.
t = 1.5;    //Wall thicknesses.

mr = 4.25; //Mendel bolt radius.
sr = 1.4; //screw radius.

module pencil_holder_clamp()
{
    h= 2*t;
    linear_extrude(height=h) handy_clamp_profile(pr,t,fr,a);
    translate([-t,pr+t]) 
    {   cube([t,d,t]);
        translate([t,d]) cube([4*t,t,t]);
        translate([t,d]) difference()
        {   cylinder(r=t,h=t);
            translate([t,-t,-t]) cylinder(r=t,h=3*t);
        }
    }
}

module mendel_clamp()
{
    h= sr+2*t;
    difference()
    {   union()
        {   clamp(mr,t,sr);
            translate([0,mr+2*t/3]) scale([2,1]) cylinder(r=2*t/3,h=h);
        }
        translate([0,mr]) cube([t,0.9*t,4*h], center=true);
    }
}
module items()
{
    mendel_clamp();
    translate([0,pr+t+fr]) pencil_holder_clamp();
}
items();
//handy_clamp_profile(20,5,50,80);
//clamp(20,5,1.5);
