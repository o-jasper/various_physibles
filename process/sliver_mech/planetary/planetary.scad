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

t=3;
th=1;
sh=0.3;

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

cir=mf*(n1+n2)+1.2*wpr+2*s;
module body()
{
    h=5*(th+sh);
    difference()
    {   translate([0,0,-2*(th+sh)]) cylinder(r=cr+t/2,h=h);
        
        translate([0,0,-(th+sh)]) cylinder(r=cir,h=8*(th+sh));
        translate([0,0,th+sh]) cylinder(r=cr,h=8*(th+sh));
        translate([0,0,-sh]) linear_extrude(height=8*th) g(n1+2*n2);
        translate([0,0,-4*th]) cylinder(r=cr/2+t/2,h=8*th);
    }
}
module cap()
{
    linear_extrude(height=th) difference()
    {   circle(cr);
        circle(min(cr/2+t,0.9*cr)); 
    }
}

//body();
//translate([0,0,5*th]) cap();

//cube([10,10,10]);
as_assembled();
module as_assembled(showy=true)
{
    adv = mech_advantage(n1=n1,n2=n2);
    translate([0,0,-th+sh/2]) rotate(360*$t*adv) center();
    color("blue") translate([0,0,th+s]) rotate([180,0,0]) intersection()
    {  body(); if(showy) translate(-100*[0,0,mf]) cube(200*[mf,mf,mf]); }
    translate([0,0,th+1.5*sh]) handle();
    color("green") for(a=[0:360/N:360*(1-1/N)]) rotate(a+360*$t)
        translate([mf*(n1+n2),0]) rotate(-360*$t*(adv-1)) wheel();
    translate([0,0,-2*(th+sh)]) cap();
}

module handle()
{
    d= cr/2;
    linear_extrude(height=th) difference()
    {   circle(cir-2*s);
        for(a=[0:360/N:360*(1-1/N)]) rotate(a) translate([mf*(n1+n2),0]) circle(wpr);
    }
    linear_extrude(height=cr/2) for(a=[0:360/N:360*(1-1/N)]) rotate(a-30)
    {   translate([-t/4,0]) square([t/2,d]);
        translate([0,d]) circle(t/4);
    }
}
