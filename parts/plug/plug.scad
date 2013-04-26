//
//  Copyright (C) 26-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

ot = 10;
t  = 10;

l=3*t;

module profile()
{
    minkowski()
    {   translate([0,t/2]) square([3*t,4*t], center=true);
        circle(ot);
    }
}

module male_base_profile()
{
    translate([0,t/2]) square([t,4*t],center=true);
    square([3*t,t],center=true);
    circle(t);
}
module male_profile()
{
    difference()
    {   male_base_profile();
        circle(t/2);
    }
    square([t/4,t],center=true);
    square([t,t/4],center=true);
}

module male_wire_holes()
{
    rotate(45) linear_extrude(height=t/2) difference()
    {   union()
        {   square([t/4,8*t],center=true);
            square([8*t,t/4],center=true);
        }
        circle(t/4);
    }
}

module male()
{
    intersection()
    {   difference()
        {   linear_extrude(height=l+t)
            {   male_profile(); }
            translate([0,0,l-t/2]) male_wire_holes();
            male_wire_holes();
            translate([0,0,l]) cylinder(r=t, h=l);
        }
        translate([0,0,-l]) scale([1.2,1.1,0.9]) 
        {   cylinder(r1=0,r2=4*t, h=4*l);
            translate([0,t]) cylinder(r1=0,r2=4*t, h=4*l);
        }
    }
}

module male_back()
{
    intersection()
    {
        union()
        {   linear_extrude(height=t)
            {
                difference()
                {   profile();
                    male_base_profile();
                }
                difference()
                {   circle(t);
                    for( a= [0,90,180,270] ) 
                        rotate(a) translate([t,0]) square([t,t]/4,center=true);
                }
            }
            translate([0,0,t]) cylinder(r1=t,r2=t/2, h=2*t/3);
        }
        difference()
        {   scale([4,6]) cylinder(r1=t,r2=0,h=2*t);
            translate([0,0,t]) for( a= [0,90,180,270] )
                rotate(a) translate([t,0]) rotate([0,-60,0]) 
                    translate([0,0,-t/2]) cylinder(r=t/8,h=4*t);
        }
    }
}

module female_profile()
{
    difference()
    {   profile();
        translate([0,t/2]) square([t,4*t],center=true);
        square([3*t,t],center=true);
        intersection()
        {   scale([2,1]) circle(t);
            square([3*t,3*t], center=true);
        }
    }
    dx = 9*t/8; dy = 7*t/8;
    translate([+dx,+dy]) circle(t/4);
    translate([+dx,-dy]) circle(t/4);
    translate([-dx,-dy]) circle(t/4);
    translate([-dx,+dy]) circle(t/4);
}

module female_wire_cut()
{
    translate([3*t/2,t/2,-t/2]) rotate([45,0,0]) cylinder(r=t/5,h=5*t);
    translate([3*t/4,t/2,-t/2]) rotate([45,0,0]) cylinder(r=t/5,h=5*t);
}

module female()
{
    
    difference()
    {   linear_extrude(height=l/2) female_profile();
        female_wire_cut();
        scale([-1,1,1])  female_wire_cut();
        scale([-1,-1,1]) female_wire_cut();
        scale([1,-1,1])  female_wire_cut();
    }
    
    difference()
    {   linear_extrude(height=l) female_profile();
        translate([0,t/2,l]) cube([3*t,5*t,l], center=true);
    }
}

module female_back_wire_cut()
{   //translate([+t,+t]) cylinder(r=t/5, h=l);
    translate([+t,+t,ot+t]) cube([t/2,t,2*t], center=true);
}

module female_back()
{   
    difference()
    {   union()
        {   translate([0,0,ot]) linear_extrude(height=l/2) intersection()
            {   female_profile();
                translate([0,t/2]) square([3*t,5*t], center=true);
            }
            linear_extrude(height=ot) difference()
            {   profile();
                circle(t/3);
            }
        }
        rotate(+45) translate([0,0,l/4]) cube([t/4,sqrt(8)*t,l/4], center=true);
        rotate(-45) translate([0,0,l/4]) cube([t/4,sqrt(8)*t,l/4], center=true);
        
        female_back_wire_cut();
        scale([-1,1,1])  female_back_wire_cut();
        scale([-1,-1,1]) female_back_wire_cut();
        scale([1,-1,1])  female_back_wire_cut();
    }
}

translate([-8*t,0]) female();
translate([-2.5*t,0]) female_back();
translate([2.5*t,0]) male();
translate([7.5*t,0]) male_back();
