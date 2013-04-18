//
//  Copyright (C) 18-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

inf = 100;
d=40;
h=18.5;
t=10;
r=d+t;
w=3*t;

module inficube(pos)
{   translate(pos) cube(2*[inf,inf,inf], center=true); }
module infisquare(pos)
{   translate(pos) square(2*[inf,inf], center=true); }

module rounder_cut(r)
{   difference()
    {   square(2*[r,r]);
        circle(r);
    }
}

module holder_profile()
{
    difference()
    {
        translate([0,h/2]) scale([1,(h+3.5*t)/r]) circle(r);
        
        translate([-inf,0]) square([inf+d,h]); //The plank
        infisquare([0,h+10+inf]); //Take of top excess
        infisquare([-inf,inf]); //Not much ontop.
        translate([sqrt(r*r-t*t)-2*t,2*t]) scale([2,1]) rounder_cut(t);
        translate([sqrt(r*r-t*t)-2*t,0]) scale([2,-1]) rounder_cut(t);
        translate([2*t,2*t]) scale([-2,1]) rounder_cut(t);
        
        translate([inf-r/2+t,-3*t/2]) //slide in headphone here.
             square([2*inf,t],center=true);
        translate([r/2,-3*t]) rounder_cut(t);

        translate([-r/2+t,-2*t]) circle(t); //It sits in here.
        translate([r/2-t,-2*t]) circle(t);
        translate([0,-2*t]) square([r/2,2*t],center=true);
    }
}

module holder()
{
    linear_extrude(height=t) holder_profile();
    difference()
    {   union()
        {   cylinder(r1=t,r2=t/2,h=w-t/2);
            translate([0,0,w-t/2]) sphere(t/2);
        }
        translate([0,inf]) inficube();
    }
}

holder();
