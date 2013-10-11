//
//  Copyright (C) 07-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fn=60;

sh=0.6;
r = 6.2/2;
s=0.7*r;
n=12;

ss=0.5;

t=s;

R = n*(r+0.5)/3.14;
Ro = R+r+2*t;
h=2*(r+t);

sr=1;

with_guide=true;

anti_sag_a=50;

module path(anti_sag=false)
{   rotate_extrude() translate([R,r+t]) 
    {   circle(r); 
        if(anti_sag) rotate(anti_sag_a) translate([r,0]) square(2*[r,r],center=true);
    }
}

module inner()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   circle(R-s/2);
            square((R-r)*[1,1],center=true);
        }
        path(true);
    }
}
module outer()
{
    difference()
    {   linear_extrude(height=h) difference()
        {   circle(Ro);
            circle(R);
        }
        if(with_guide)
            translate([0,0,r+t-sh]) cylinder(r=R+r+s+ss, h=2*sh);
        path();
    }
}
module guide()
{
    linear_extrude(height=sh) difference()
    {   circle(R+r+s);
        circle(R);
        for(a= [0:360/n:360]) rotate(a) translate([R,0]) circle(r+2*ss);
    }
}
module outer_half()
{   intersection()
    {   outer();
        difference()
        {   union()
            {   cube([8*Ro,8*Ro,h],center=true);
                for(a=[90,270]) rotate(a) translate([Ro,s]) cube(2*[s,Ro,h],center=true);
            }
            for(a=[0,180]) rotate(a) translate([Ro,s]) cube(2*[s,Ro,h],center=true);
        }
    }
}

module as_show(a=0,as_assembled=false)
{
    outer_half(with_guide=with_guide);
    if(as_assembled) translate([0,0,h]) rotate(30) rotate([0,180,0]) 
                         outer_half(with_guide=with_guide);
    inner();
    rotate(a)
    {   if(with_guide) translate([0,0,r+t-sh/2]) guide();
        for(a=[0:360/n:360]) rotate(a) 
            translate([R,0,r+t]) color([1,0,0]) sphere(r);
    }
}

module as_assembled(a=0)
{   as_show(a,true, with_guide=with_guide); }

module just_show()
{
    difference()
    {   as_assembled();
        for(a=[180,210]) rotate(a) cube(R*[8,8,8]);
    }
}

module as_print()
{
    translate([2*Ro,0]) outer_half(with_guide=with_guide);
    translate([0,2*Ro]) outer_half(with_guide=with_guide);
    inner();
    if(with_guide) translate([-2*Ro,0]) guide();
}

just_show();

