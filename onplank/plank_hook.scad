//
//  Copyright (C) 18-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

d=15;
h=18.5;
t=6;
r=d+t;
w=3*t; //You can add this for a 'tower' that stops it rotating.
       // (in entry axis direction) Negative to not do it.

inf = 3*(r+h+w);

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
        infisquare([0,h/2+3*t+inf]); //Take of top excess
        infisquare([-inf,inf]); //Not much ontop.
        infisquare([0,-h/2-2.75*t-inf]);
        
        translate([sqrt(r*r-t*t)-2*t,h/2+2*t]) scale([2,1]) rounder_cut(t);
        translate([sqrt(r*r-t*t)-2*t,0]) scale([2,-1]) rounder_cut(t);
        translate([2*t,h/2+2*t]) scale([-2,1]) rounder_cut(t);
        
        translate([inf-r/2+t,-3*t/2]) //slide in headphone here.
             square([2*inf,t],center=true);
        translate([r/2,-3*t]) rounder_cut(t);
        translate([r/2+t,-t]) scale([1,-1]) square([inf,inf]); //bit of trash.
        translate([r/2-t,-3*t]) scale([1,-0.8]) rounder_cut(2*t);

        translate([-r/2+t,-2*t]) circle(t); //It sits in here.
        translate([r/2-t,-2*t]) circle(t);
        translate([0,-2*t]) square([r-2*t,2*t],center=true);
    }
}

module pin() //Pin so you can also support the other direction.
{
    difference()
    {   rotate([90,0])
        {   cylinder(r1=t,r2=t/2,h=w-t/2);
            translate([0,0,w-t/2]) sphere(t/2);
            translate([0,0,1.5*t-w+t]) cylinder(r2=2*t/3,r1=t/3, h=t/4); //'Catch' it.
            translate([0,0,1.5*t-w]) cylinder(r2=t/2,r1=t/8, h=w-1.5*t);
        }
        inficube([0,0,-inf]);
    }
}

module hook() //hook itself.
{
    if( w<0 )
    {
        linear_extrude(height=t) holder_profile();
    }
    else
    {   difference()
        {   union()
            {   linear_extrude(height=t) holder_profile();
                difference()
                {   union()
                    {   cylinder(r1=t,r2=t/2,h=w-t/2);
                        translate([0,0,w-t/2]) sphere(t/2);
                    }
                    translate([0,inf]) inficube();
                }
            }
            rotate([90,0]) pin();
        }
    }
}

hook();
//pin();
