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

include<../gear_outer.scad>

pitch = 180;
mf= 49*pitch/(500*36);

t=5;
th=1;
sh=0.2;

pi=3.14;

s=0.1;

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

sr=1;
n_body_hole= 12;//floor((6.29*cr+t/2)/(8*sr));
f=0.2;

module insert()
{
    linear_extrude(height=th) difference()
    {   square(2*[cr,cr],center=true);
        g(n1+2*n2);
    }
}

module center(gear=true)
{   
    difference()
    {   union()
        {   cylinder(r=cr-2*s,h=th);
            cylinder(r=mf*(n1+2.5),h=0.5*th);
            translate([0,0,0.5*th]) cylinder(r1=mf*(n1+2.5),r2=mf*n1, h=0.5*th);
            if(gear) linear_extrude(height=2*th+1.6*sh) g(n1);
        }
        cube(mf*[n1,n1,n1+2*n2],center=true);
        for(a=[0:360/N:360*(1-1/N)]) rotate(a) translate([mf*(n1+n2),0,-mf]) 
                                         cylinder(r=wpr,h=n1*mf); 
    }
}

function mech_advantage() = 2*(1+n2/n1);

echo(mech_advantage());

module body()
{   w=2*cr+t/4+2*s;
    difference()
    {   hull()
        {   translate([0,0,th/2]) cube(2*[cr+t/2,cr+t/2,th],center=true);
            translate([0,0,-2*(th+sh)]) cylinder(r=cr+t/2,h=th);
            translate([0,0,+2*(th+sh)]) cylinder(r=cr+t/2,j=th);
        }
        translate([0,0,-4*th]) cylinder(r=cr/2+t,h=8*th);
        translate([0,0,-th]) cylinder(r=cr,h=3*th+3*sh);
        translate([-w,-w]/2) cube([w,w,th+3*sh]);
    }
}

module half_body()
{
    rotate([90,0,0]) intersection()
    { body(); translate(-8*n1*mf*[0,1,0]) cube(2*mf*n1*[8,8,8],center=true); }
}
//cube([10,10,10]);
as_assembled();
module as_assembled()
{
    adv = mech_advantage(n1=n1,n2=n2);
    translate([0,0,-th+sh/2]) rotate(360*$t*adv) center();
    color("blue") rotate([-90,0,0]) half_body(); 
    color("red") insert();
    translate([0,0,th+1.5*sh]) handle();
    color("green") for(a=[0:360/N:360*(1-1/N)]) rotate(a+360*$t)
        translate([mf*(n1+n2),0]) rotate(-360*$t*(adv-1)) wheel();
}

//--Extras.

module _handle(r)
{   for(a=[0:360/N:360*(1-1/N)]) rotate(a-30)
    {   translate([-r,0]) square([2*r,cr-t]);
        translate([0,cr-t]) circle(r);
    }
}

module handle()
{
    linear_extrude(height=th) difference()
    {   circle(cr-2*s);
        for(a=[0:360/N:360*(1-1/N)]) rotate(a) translate([mf*(n1+n2),0]) circle(wpr);
    }
    difference()
    {   linear_extrude(height=cr/2) _handle(t/4);
        translate([0,0,th]) linear_extrude(height=cr/2-4*th) _handle(t/8);
    }
}
//translate([0,0,6*th]) handle();
