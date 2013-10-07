//
//  Copyright (C) 07-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fn=60;

sh=1;
r = 6.2/2;
s=0.7*r;
n=6;

ss=0.5;

t=s;

R = n*(r+s)/3.14;
Ro = R+r+2*t;
h=2*(r+t);

sr=1;

module path()
{   rotate_extrude() translate([R,r+t]) circle(r); }

module inner()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   circle(R-s/2);
            square((R-r)*[1,1],center=true);
        }
        path();
    }
}
module outer()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   circle(Ro);
            circle(R+s/2);
        }
        translate([0,0,r+t-sh]) cylinder(r=R+r+s+ss, h=2*sh);
        path();
    }
}
module guide()
{
    linear_extrude(height=sh) difference()
    {   circle(R+r+s);
        circle(R);
        for(a= [0:60:360]) rotate(a) translate([R,0]) circle(r);
    }
}
module _outer_half()
{   intersection()
    {   outer();
        difference()
        {   translate([Ro/2-t/2,0]) cube([Ro-t,8*Ro,8*Ro],center=true);
            for(z=[2*sr,h-2*sr]) translate([0,0,z]) rotate_extrude()
                translate([Ro,0]) circle(sr); 
        }
    }
}
module outer_half()
{   rotate([0,90,0]) _outer_half(); }

module as_show(a=0,as_assembled=false)
{
    _outer_half();
    if(as_assembled) rotate(180) _outer_half();
    inner();
    rotate(a)
    {   translate([0,0,r+t-sh/2]) guide();
        for(a=[0:360/n:360]) rotate(a) 
            translate([R,0,r+t]) color([1,0,0]) sphere(r);
    }
}

module as_assembled(a=0)
{   as_show(a,true); }

module as_print()
{
    translate([Ro,0,Ro-t]) outer_half();
    translate([Ro+h+t,0,Ro-t]) outer_half();
    inner();
    translate([-2*Ro,0]) guide();
}

as_show(30);

