//
//  Copyright (C) 17-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fn=60;

n=6;

sa=360/(n+0.5); //The half is so it can only be inserted one way.

R=8;
h = 2*R;
fz=1.4;
t=0.5;

sr=0.5;

module plug()
{   intersection()
    {   union()
        {   scale([1,1,fz]) sphere(R); //Stretched sphere.
            translate([0,0,h/2]) cylinder(r1=R/2,r2=0.1*R,h=R);
        }
        translate([0,0,-h/2]) linear_extrude(height=2*h) difference()
        {   circle(R);
            for(a=[0:sa:360-sa]) rotate(a) //Inward-bendability.
                {   translate([R,0]) scale([0.8,0.2]) circle(R);
                    // Hole for wire.
                    rotate(sa/2) translate([0.6*R,0]) circle(sr);
                }
        }
    }
}
module plug_top_cover()
{    cylinder(r1=0.3*R,r2=0.1*R,h=R/2); }

module socket()
{
    difference()
    {   translate([0,0,-h/2-t]) cylinder(r=R+t,h=h+t);
        intersection()
        {   scale([1,1,2*fz]) sphere(R); //Basic shape.
            translate([0,0,-h/2]) linear_extrude(height=h) difference()
            {   circle(R-t);
                for(a=[0:sa:360-sa]) rotate(a) //Matching the petals.
                    {   translate([R,0]) scale([0.7,0.15]) circle(R);
                    }
            }
        }
        for(a=[0:sa:360-sa]) rotate(a) //Room for the wire.
        {   for(y=0.15*R*[1,-1]) translate([0,y]) rotate([0,90,0]) cylinder(r=sr,h=8*R);
            translate([R+t,0,sr]) rotate([0,180,0]) cylinder(r1=sr+0.14*R, r2=sr,h=h);
        }
    }
}

module socket_cover()
{   translate([0,0,-h/2]) linear_extrude(height=h) 
        difference(){ circle(R+2*t); circle(R+t); } 
}

module just_show()
{
    translate([0,0,-h*$t]) socket_cover();
    color("blue") socket();
    translate([0,0,h*$t]) plug();
}

module as_print()
{
    plug();
    translate([2*(R+t),0,t]) socket();
    translate(2*[-R-2*t,0]) socket_cover();
}

//just_show();
as_print();
