//
//  Copyright (C) 29-10-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//TODO the planets have to fit, not all counts work?

$fn = 40;

include<gear_outer.scad>

pitch = 180;
mf= 49*pitch/(500*36);

t=5;
th=1;
sh=0.2;

pi=3.14;

s=0.2;

module g(n)
{   gear_outer(number_of_teeth=n, circular_pitch=pitch); }


//TODO calculate ratio.
n1=9; n2=8; N=3;

wpr=6.3*mf; //Radius of pegs of wheels.
cr= mf*(n1+2*n2+4);
module wheel()
{
    sx= 1-0.5/n2;
    scale([sx,sx,1])
    {   linear_extrude(height= th) g(n2);
        cylinder(r=wpr-s,h=2*th);
    }
}

n_body_hole=4;
sr=1;

module cap_profile()
{
    circle(cr+t/2);
    for(a=[0:360/n_body_hole:360*(1-1/n_body_hole)]) rotate(a) 
               translate([cr+t/2,0]) circle(0.75*t);
}

module _body()
{   difference()
    {   circle(cr+t);
        for(a=[0:360/n_body_hole:360*(1-1/n_body_hole)]) rotate(a) 
               translate([cr+t/2,0]) circle(sr);
    }
}

module body()
{
    difference()
    {   linear_extrude(height=3*(th+sh)) _body();
        translate([0,0,th+sh]) cylinder(r=cr,h=8*th);
        translate([0,0,2*(th+sh)]) linear_extrude(height=8*th) 
            cap_profile(cr=cr,t=t,n_body_hole=n_body_hole);
        translate([0,0,-th]) linear_extrude(height=8*th) g(n1+2*n2);
    }
}

module cap()
{
    linear_extrude(height=th) intersection()
    {   cap_profile(); 
        difference(){ _body(); circle(mf*n1+n2); } 
    }
}

translate([0,0,8*th]) cap();
//translate([0,4*mf*(n1+2*n2+4)]) 
module center(gear=true)
{   
    difference()
    {   union()
        {   cylinder(r=cr-s,h=th);
            cylinder(r=mf*(n1+2.5),h=0.5*th);
            translate([0,0,0.5*th]) cylinder(r1=mf*(n1+2.5),r2=mf*n1, h=0.5*th);
            if(gear) linear_extrude(height=2*th+sh) g(n1);
        }
        cube(mf*[n1,n1,n1+2*n2],center=true);
        for(a=[0:360/N:360*(1-1/N)]) rotate(a) translate([mf*(n1+n2),0,-mf]) 
                                         cylinder(r=wpr,h=n1*mf); 
    }
}

module handle_center()
{
    l=(n1+n2)*mf;
    center(false);
    linear_extrude(height=n1*mf) for(a=[0,120,240]) rotate(a-30) union()
    {   translate([-t/4,0]) square([t/2,l]);
        translate([0,l]) circle(t/4);
    }
}
translate([0,0,10*th]) handle_center();
module bottom()
{
    difference()
    {   circle((n1+n2)*mf;
    for(a=[0:360/N:360*(1-1/N)]) rotate(a) translate([mf*(n1+n2),0]) circle(r=wpr,h=n1*mf);
}
translate([0,0,-5*th]) bottom();

function mech_advantage() = 2*(1+n2/n1);

echo(mech_advantage());

module as_assembled()
{
    adv = mech_advantage(n1=n1,n2=n2);
    translate([0,0,-th+0.1]) rotate(360*$t*adv) center();
    color("blue") body();
    color("green") for(a=[0:360/N:360*(1-1/N)]) rotate(a+360*$t)
        translate([mf*(n1+n2),0]) rotate(-360*$t*(adv-1)) wheel();
}

//cube([10,10,10]);
as_assembled();
