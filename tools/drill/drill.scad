//
//  Copyright (C) 08-06-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<parametric_involute_gear_v5.0.scad>

include <nut.scad>

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
        {   square(2*[10*or,or+nh], center=true);
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
            base_holder(h=bh);
            translate([0,0,bh]) cylinder(r=r+t/2, h=or);
        }
        cylinder(r=r+t,h=t);
        translate([0,0,bh]) cylinder(r1=r,r2=r/2, h=or/2);
    }
}
l=70;
hl=l;

n=20;
oy= 15*n/6-3*t;

module loose_gear()
{
    rotate([180,0]) bevel_gear(face_width=2*t, number_of_teeth=n, bore_diameter=2*t);
    
    difference() 
    {   linear_extrude(height=4*t) union()
        {   circle(2.5*t);
            translate([0,oy/2]) square([2*t,oy],center=true);
        }
        translate([8*t,0,3*t]) rotate([0,-90,0]) cylinder(r=sr, h=16*t);
        cylinder(r=1.5*t,h=8*t);
    }
    translate([0,oy]) difference()
    {   union()
        {   cylinder(r=2*t,h=hl-t);
            translate([0,0,hl-3*t]) cylinder(r1=2*t,r2=3*t,h=2*t); 
            translate([0,0,hl-t]) cylinder(r1=3*t,r2=1.1*t,h=t); 
        }
        translate([0,0,hl]) sphere(t);
    }
}

//translate([l,0]) loose_gear();

translate([l,0]) bit_part();
l=max(bh+or+6*t, 70);

et=0.5;

oy2= 15*11/6-3*t;

//Space for toggle system that blocks rotation.
module toggle_space()
{   
    linear_extrude(height=2*t) union()
    {   translate([-oy-t,0]) square([2*(oy+t+et),2*t+et],center=true);
        translate([-or,0]) circle(2*t+et);
        translate([0]) circle(2*t+et);
    }
    translate([-oy/2,0,-4*t]) cube([oy/2,t+et,8*t+et],center=true);
}

module toggle()
{   
    union()
    {   translate([-or,0]) linear_extrude(height=2*t)
        {   intersection()
            {   translate([-oy/2,0]) square([oy,2*t],center=true);
                translate([or,0]) circle(3*or+r+t);
            }
            translate([0]) circle(2*t);
        }
        translate([0,0,-8*t]) linear_extrude(height=5*t) difference()
        {   translate([-or,0]) circle(3.5*t);
            scale([1,1.6]) circle(or);
            square([3*or,2*t],center=true);
            translate([or,0]) circle(oy2+t);
        }
        
        translate([-oy/4+t-or,0,-4*t]) cube([2*t,t,8*t],center=true);
    }
}


module body()
{
    //bh+or
    difference()
    {  
        union()
        {   linear_extrude(height=l) intersection()
            {   scale([(oy2+4*t)/or,1]) circle(or);
                translate([-3*or,0]) circle(3*or+r+t);
            }
            translate([0,0,oy+6*t]) rotate([0,90,0]) 
            {   cylinder(r=1.5*t,h=r+5*t);
                cylinder(r=or,h=r+t);
            }
        }
        translate([0,0,2*t]) difference() //Space for gear and bit-associated.
        {   cylinder(r=oy2+t, h=bh+or+2*et);
            cylinder(r=r+t,h=t-et);
        }
        difference() //Round that bit properly.
        {   translate([l,0]) cube([2*l,2*l,8*t],center=true);
            cylinder(r=r+t,h=8*t);
        }
        cylinder(r=r,h=h+2*t); //Drill bit hole.
        translate([0,0,bh+or+2*t]) cylinder(r=r+t/2+et,h=2*t+3*et); //Top fitting
        translate([0,0,bh+or+5*t+et]) toggle_space();
    }
}

//body();
//translate([0,3*or]) toggle();

module as_assembled() //TODO
{
    body();
    color([0,0,1]) translate([0,0,bh+or+5*t+et]) toggle();
}

as_assembled();
