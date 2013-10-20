//
//  Copyright (C) 20-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

w= 80; //100;(quickfit)
l= 40;
th=5;

t=4;

s=0.3;

sr=1.5;
sR=1.65;

pd = 5;
pfmt = 0.5; //'membrane' spring holds it in.

phw = 15; //Pen holder width.
pht = 2;  //Pen holder wall thicknesses.
phh = 2*phw; //pen holder height.

dz = 4*t; //Range of motion.(only in structure)

ds = phw/2+3*sR; //

clamping_flap = true;

module pen_holder()
{
    linear_extrude(height=phh) difference() 
    {   square([phw,phw],center=true);
        difference()
        {   square((phw-2*pht)*[1,1],center=true);
            for(x=[-pd,pd]/2) translate([x,0]) square([pfmt,phw],center=true);
        }
    }
    linear_extrude(height=t) for(a=[0,180]) rotate(a) difference()
    {   translate([phw/2,0]) hull()
        {   translate([2*sR,0]) circle(sR+t/2);
            square([pht,2*sR+t],center=true);
        }
        translate([phw/2+2*sR,0]) circle(sR);
    }
    //Flap you put a clamp on to control it with a filament.
    if(clamping_flap) translate([0,phw/2,phh]) rotate([90,0,0]) 
        linear_extrude(height=pht)
        {   square(phw*[1,1],center=true);
            translate([0,phw/2]) circle(phw/2);
        }
}

module slider_add()
{   //Main block shape.
    linear_extrude(height=phh) square((phw+2*pht+2*s)*[1,1],center=true);
    linear_extrude(height=dz+2*t)  //'shoulders' with springs in them go here.
    {   square([2*ds,2*sR+2*t],center=true);
        for(a=[0,180]) rotate(a) translate([ds,0]) circle(sR+t);
    }
}

module slider_sub()
{
    q=2*sR+t/4+s;
    //Sliding of thingy for springs.
    translate([0,0,-dz]) linear_extrude(height=2*dz)
    {   square([2*ds,2*sR+t+2*s],center=true);
        for(x=[-ds,ds]) translate([x,0]) circle(sR+t/2+s);
    }
    // Sliding of square part.
    cube((phw+2*s)*[1,1,0]+[0,0,8*phh],center=true);
    for(x=[-ds,ds]) translate([x,0,-2*q]) 
    {   cylinder(r=sr,h=2*phh); // Holes for screws/wires that guide the spring.
        cylinder(r1=2*q,r2=0, h=4*q); //Slight guide tapering.
    }
}

$r = 2/2; // radius of filament(accounted, actually made a bit bigger than needed)
$rt = 1.75; //Tube radius

//Holds the bowden tubes for filament control.
//TODO place high about holder.. somehow
module bowden_holder()
{
    q= 2*$rt+t/2;
    difference()
    {   linear_extrude(height=2*t) intersection()
        {   scale([1.2,1]) hull() for(y=[q,-q]) translate([0,y]) circle(q);
            square([2*q,8*q],center=true);
        }
        translate([0,0,t/2]) linear_extrude(height=t) for(a=[90,270]) rotate(a)
        {   translate([q,0]) circle(2*$rt);
            translate([2*q,0]) square([2*q,4*$rt],center=true);            
        }
        translate([0,0,t]) linear_extrude(height=8*t) for(a=[90,270]) rotate(a)
        {   translate([q,0]) circle($rt);
            translate([2*q,0]) square([2*q,$rt],center=true);            
        }
        for(y=[q,-q]) translate([0,y,-q]) cylinder(r=$r,h=8*q);
    }
}

translate([0,0,phh]) bowden_holder();

module holder()
{
    difference()
    {   union()
        {   translate([0,0,th/2]) cube([w,l,th],center=true);
            for(y= (phw+2*pht)*[1,-1]/2) translate([0,y]) slider_add();
        }
        for(y= (phw+2*pht)*[1,-1]/2) translate([0,y]) slider_sub();
    }
}

module slider()
{
    difference()
    {   slider_add();
        slider_sub();
    }
}
//pen_holder();

//slider();
//translate([0,2*phw]) pen_holder();

holder();

