//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Well, the best design of a wall coat hanger hook i could think of looks like
// a penis...

//TODO go at this anew.

// TODO make the height on the wall side configureable.

use <nut_hole.scad>

h=100;
t=20;
d=50;
dh = 60;
a=45;
s = t/2;

a = 60; //TODO upto an angle.

f=0.8;

it = t/2;

vertical_cylinder_p = false;

bt = t/2; //+s; //Even ballsier.

hole_r = t/16;
head_r = t/8; //Radius of screw(or whatever) head.
head_d = t/12; //Depth of embedding.
head_dr = t/12;
head_dz = t/6;

module quarter_torus(R,r)
{
    d= R+2*r;
    difference()
    {   rotate_extrude() translate([R,0]) circle(r);
        rotate(a = 60) translate([0,2*d]) cube(4*d*[1,1,1], center=true);
        translate([-2*d,0]) cube(4*d*[1,1,1], center=true);
    }
}

function sqr(x) = x*x;

module _lower_hook_inner(m)
{
    x = t;
    y = d - sqrt(sqr(d+t/2) - x*x) +t/2;

    translate([0,0,-d]) 
    {   rotate(v=[0,1,0], a=90) 
        {   translate([0,0,t/2]) cylinder(r1=bt-m, r2=t/2-m, h=t/2);
            translate([0,0,-t/2]) cylinder(r=bt-m, h=t);
        }
    }
    translate([t,0]) rotate(v=[1,0,0], a=90)
    {   quarter_torus(d,t/2-m);
        translate([d,0]) sphere(t/2-m);
        
        translate([x,y]) scale([-(t+x)/d,1]) quarter_torus(d,t/2-m);
    }
    translate([0,0,y]) scale([(t+x)/d,1]) sphere(t/2-m);
}

module _lower_hook()
{
    x = t;
    y = d - sqrt(sqr(d+t/2) - x*x) +t/2;

    translate([0,0,-d]) rotate(v=[0,1,0], a=90) 
    {   translate([0,0,t/2]) cylinder(r1=bt, r2=t/2, h=t/2);
        cylinder(r=bt, h=t/2);
    }
    translate([t,0]) rotate(v=[1,0,0], a=90)
    {   quarter_torus(d,t/2);
        translate([d,0]) sphere(t/2);
        
        translate([x,y]) scale([-(t+x)/d,1]) quarter_torus(d,t/2);
    }
    translate([0,s,t/2-dh]) rotate(a=90, v=[1,0,0]) scale([3,1]) difference()
    {   union()
        {   cylinder(r=t/2, h=t);
            sphere(t/2);
            translate([0,0,t]) sphere(t/2);
        }
        rotate(a=90, v=[1,0]) translate(t*[1,-1,-4]/2) 
            scale([f,1]/2) cylinder(r=t, h=4*t);
        rotate(a=90, v=[1,0]) translate(t*[1,2+2*s/t,-4]/2) 
            scale([f,1]/2) cylinder(r=t, h=4*t);
    }
    
    translate([0,0,y]) scale([(t+x)/d,1]) sphere(t/2);
    if( vertical_cylinder_p )
    {    translate([0,0,-d]) scale([(t+x)/d,1]) cylinder(h=d, r1=bt, r2=t/2); }
}

module nut_place()
{
    translate([t/2,0]) scale([-1,1]) rotate(v=[0,1,0], a=90) 
        substract_hole(10*t,hole_r, head_r,head_d,head_dr,head_dz);
}

module nut_place_2()
{   nut_place();
    re = head_r + head_dr*2*head_dz/head_dz;
    translate([t/2,0]) rotate(a=90, v=[0,1,0]) cylinder(r=re, h = 5*t);
}

module lower_hook()
{
    difference()
    {   _lower_hook();
        nut_place();
        translate([0,t-head_r-head_dr,-d]) nut_place_2();
        translate([0,-(t-head_r-head_dr),-d]) nut_place_2();
        translate([0,0,-d-(t-head_r-head_dr)]) nut_place_2();
        
        if( it>0 )
        { _lower_hook_inner(it/2); }
        
        translate([-2*d,0]) cube(4*d*[1,1,1], center=true);
    }
}

//_lower_hook_inner(t/4);
/*
translate([t,0]) rotate(v=[1,0,0], a=90) 
{   quarter_torus(d,t/4);
    translate([d,0]) sphere(t/4);
    }*/

lower_hook();

//translate([t/2,0]) scale([-1,1]) rotate(v=[0,1,0], a=90) 
//    substract_hole(100,hole_r, head_r,head_d,head_dr,head_dz);

