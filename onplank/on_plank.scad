//
//  Copyright (C) 30-05-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.1;

//Maximum plank thickness.
max_pt = 30;
//Thickness around plank..
t= 4;
//Width around plank.
w= 10;
//Radius of wall.
r= t/3; 
//Length grabbing plank;
gl=3*w;
//Guide height
gh=w;
gt = t/4;
twist_a=180;
//Factor to make it slider better.
pf=0.8;

//Feh importing stuff is inconvenient, they should implement r= on stuff.
module rounded_rect(w,h,r)
{
    union()
    {   translate([0,r]) square([w,h-2*r]);
        translate([r,0]) square([w-2*r,h]);
        for( pos = [[r,r], [w-r,r], [r,h-r], [w-r,h-r]] ) translate(pos) circle(r);
    }
}

module on_plank_profile()
{
    w=gl+t; h= max_pt+3*t;
    difference()
    {   rounded_rect(w,h,r);
        translate([0,t]) square([gl,max_pt+t]);
    }
}

module _pusher(f)
{
    linear_extrude(height=gh, twist=twist_a) union()
    {   for( a = [0:60:360] ) rotate(a) translate([w/2-gt,0]) circle(f*2*gt/3);
        circle(w/2-gt);
    }
}

module on_plank()
{
    difference()
    {   linear_extrude(height=w) on_plank_profile();
        translate([gl/2,-t,w/2]) rotate([-90,0]) cylinder(r=w/2-gt/4,h=max_pt+t);
    }
    translate([gl/2,t,w/2]) rotate([90,0]) difference()
    {   intersection() //(Scale and intersect to avoid zero-angle bed touching.)
        {   scale([1,1.2]) cylinder(h=gh, r=w/2);
            cube([w,w,2*gh], center=true); 
        }
        _pusher(1);
    }
}

module pusher()
{
    _pusher(pf);
    cylinder(r= w/2-2*gt, h=gh+t/2);
}

module plank_push()
{
    difference()
    {   linear_extrude(height=t) rounded_rect(w,gl,r);
        translate([w/2,gl/2,t/2]) cylinder(r=w/2-2*gt, h=t);
    }
}


module as_print()
{
    on_plank();
    translate([gl-t,2*t]) rotate(90) plank_push();
    translate([gl-t-w/2,3*t+w + w/2]) rotate(90) pusher();
    
}

as_print();

//TODO would-be-nice to have as_show.
