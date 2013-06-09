//
//  Copyright (C) 08-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//NOTE: probably not robust against size changes; in particular with regards to
// the gear space.(Control gx,gz and  perhaps gear_thickness, and cone_distance.)

use<parametric_involute_gear_v5.0.scad>

include <nut.scad>

$fs=0.6;

//Radius of screw space. (oversized! Smaller things fit in to make it work better.
r = 5;
//Thicknesses.
t = 3;
//Bit length.
h = 35;

or=r+t;

module base_holder()
{   difference()
    {
        linear_extrude(height=h) intersection()
        {   square(2*[10*or,or+nh+t], center=true);
            difference()
            {   union()
                {   scale([1,1.6]) circle(or);
                    square([3*or,2*t],center=true);
                }
                circle(r);
            }
        }
        for(a = [0,180] ) rotate(a) translate([0,r+2*nh,nt]) rotate([90,0,0]) 
        {   linear_extrude(height=nh) nut_and_length(h);
            for(y=[nh:3*nh:h-nh]) translate([0,y,-h]) cylinder(r=sr,h=2*h);
        }
    }
}

bgt=max(3*t,or/2);

bh=max(h,bgt + 2*nt+t); //Bit height

module bit_part()
{   difference()
    {   union()
        {   bevel_gear(face_width=bgt, number_of_teeth=6, bore_diameter=2*r);
            translate([0,0,bgt]) base_holder(h=4*nt);
            translate([0,0,bgt+4*nt]) cylinder(r=r+t, h=bh-(bgt+4*nt));
            translate([0,0,bh]) cylinder(r=r+t/2, h=or);
        }
        cylinder(r=r+t,h=t);
        translate([0,0,bh]) cylinder(r1=r,r2=r/2, h=or/2);
    }
}
l=70;
hl=l;

n=16;
oy= 15*n/6-3*t;

module loose_gear()
{
    rotate([180,0]) bevel_gear(face_width=2*t, number_of_teeth=n, bore_diameter=3*t+et);    
    difference() 
    {   union()
        {   cylinder(r=2.5*t, h=2*t);
            rotate([-90,0]) cylinder(r=1.8*t, h=oy);
            for( a=[60,-60] ) rotate(a) 
            {   rotate([90,0]) cylinder(r1=2*t, r2=t,h=oy-t);
                translate([0,-oy+t]) scale([1,1.5,1]) sphere(t);
            }
        }
        translate([8*t,0,3*t]) rotate([0,-90,0]) cylinder(r=sr, h=16*t);
        translate([0,0,-4*t]) cylinder(r=1.5*t,h=9*t);
    }
    translate([0,oy]) difference() //Handle
    {   union()
        {   cylinder(r=2*t,h=hl-t);
            translate([0,0,hl-3*t]) cylinder(r1=2*t,r2=3*t,h=2*t); 
            translate([0,0,hl-t]) cylinder(r1=3*t,r2=1.1*t,h=t); 
        }
        cylinder(r=t,h=hl-2*t);
        translate([0,0,hl]) sphere(t);
    }
}

module gear_nob()
{
    difference()
    {   union()
        {   cylinder(r=2.5*t,h=3*t);
            translate([0,0,3*t]) scale([1,1,0.2]) sphere(2.5*t);
        }
        cylinder(r=1.5*t+et/2,h=9*t);
        translate([-l,0,1.5*t]) rotate([0,90]) 
        {   cylinder(r=sr,h=2*l);
        }
    }
}

l=max(bh+or+6*t, 70);

et=0.5;

oy2= 15*11/6-1.1*t;

hl=60;

gx = 2*r+3*t;
gz = bh+2*et+7*t;

module body()
{
    intersection() 
    {   difference()
        {  
            union()
            {   linear_extrude(height=l) intersection()
                {   scale([(oy2+4*t)/or,1]) circle(or);
                    translate([-3*or,0]) circle(3*or+r+t);
                }
            }
            translate([0,0,2*t]) difference() //Space for gear and bit-associated.
            {   cylinder(r=oy2+t/2, h=bh+2*et);
                cylinder(r=r+t,h=t-et);
            }
            difference() //Round that bit properly.
            {   translate([l,0]) cube([2*l,2*l,8*t],center=true);
                cylinder(r=r+t,h=8*t);
            }
            cylinder(r=r,h=h+2*t); //Drill bit hole.
            translate([0,0,bh+or+2*t]) cylinder(r=r+t/2+et,h=2*t+3*et); //Top fitting
        }
        //Cut of edge.
        cylinder(r=oy2+3*t,h=l);
        translate([0,l]) rotate([90,0,0]) scale([0.8,1]) cylinder(r=l,h=3*l);
    }
    translate([-oy2-t,0]) intersection()
    {   translate([0,0,0.7*(r+t)]) union() 
        {   rotate([0,-90,0]) scale([1,0.6]) cylinder(r=r+t, h=hl-r-t);
            translate([-hl+r+t,0]) scale([0.9,0.8,1.2]) sphere(r+t);
        }
        translate([0,0,l]) cube(l*[2,2,2],center=true);
    }
    difference()
    {   translate([0,0,gz]) rotate([0,90,0])  //Gear goes on this
        {   cylinder(r=1.5*t,h=gx+5*t);
            cylinder(r=or,h=gx);
        }
        translate([gx+3.5*t,0]) cylinder(r=sr,h=9*l);
    }
}

//body();
//translate([0,3*or]) toggle();

module as_assembled()
{
    body();
    translate([0,0,2*t+et]) rotate(90+60*$t) color([0,0,1]) bit_part();
    translate([gx+et+9*t,0,gz]) rotate([0,90,0]) rotate(360*$t/16) color([0,0,1]) loose_gear();
    translate([gx+2*et+11*t,0,gz]) rotate([0,90,0]) color([1,0,0]) gear_nob();
}

//as_assembled();

module body_cutter(sub)
{   union()
    {   difference()
        {   translate([0,0,bh+2*(t+et)]) cylinder(r=l,h=l);
            translate([-oy2-t,0]) cube(2*[t,t,l],center=true);
            if( sub )
            {   translate([0,0,bh+2*et-t]) rotate([0,-45,0]) cylinder(r=sr,h=l);
                translate([0,0,bh+2*et-3*t]) rotate([0,-45,0]) cylinder(r=sr,h=l);
                translate([-4*t,0,bh+2*(et+t)]) cube([2*t,2*sr,2*t],center=true);
            }
        }
        if( !sub )
        {   translate([0,0,bh+2*et-t]) rotate([0,-45,0]) cylinder(r=sr,h=l);
            translate([0,0,bh+2*et-3*t]) rotate([0,-45,0]) cylinder(r=sr,h=l);
            translate([-oy2-1.8*t,0,bh+2*(t+et)+4*t]) cylinder(r=sr,h=l);
        }
    }
}
module upper_body() //TODO how to make this easily printable?
{   intersection()
    {   body();
        body_cutter(true);
    }
}
module lower_body()
{   difference()
    {   body();
        body_cutter(false);
    }
}
//upper_body();

//as_assembled();
//bit_part();
loose_gear();
