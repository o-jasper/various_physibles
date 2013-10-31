//
//  Copyright (C) 31-10-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// Feh they overcomplicate shit and shits rotating badly.
//This particular file can only complicate or break mine.
//include<MCAD/teardrop.scad> 

$fn=80;

w= 80; //100;(quickfit)
l= 40;
th=5;

t=3;

s=0.4;

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
top_clamping_flap = false;

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
    {   hull()
        {   translate([ds,0]) circle(sR+t/2);
            translate([0,-sR-t/2]) square([pht,2*sR+t]);
        }
        translate([ds,0]) circle(sR);
        square((phw-pht)*[1,1],center=true);
    }
    //Flap you put a clamp on to control it with a filament.
    if(top_clamping_flap) translate([0,phw/2,phh]) rotate([90,0,0]) 
        linear_extrude(height=pht)
        {   square(phw*[1,1],center=true);
            translate([0,phw/2]) circle(phw/2);
        }
    if(clamping_flap) difference()
    {   linear_extrude(height=6*sr) translate([-t/4+s,phw/2]) square([t/2-2*s,3*t+sr]);
     //Hole for screw. Might later add something that screws on here to clamp on the
     // filament.
        translate([-4*t,phw/2 + 2*t+sr/2,t+sr]) rotate([0,90,0]) linear_extrude(height=8*t)
        {   circle(sr);
            translate([-sr/sqrt(2),0]) rotate(45) square([sr,sr],center=true);
        }
    }
}

$r = 2/2; // radius of filament(accounted, actually made a bit bigger than needed)
$rt = 1.75; //Tube radius

q= 2*$rt+t/2;

//Tube holder bit(not a separate part)
module tube_holder()
{
    w=2*(2*$rt+t/2);
    difference()
    {   intersection()
        {   translate([0,w/2]) rotate([90,0,0]) linear_extrude(height=w) //Main shape.
                polygon([[0,-w/2], [0,0], [w,0], [w,-w/2], [0,-3*w/2]]);
            translate([w/2,0,-4*w]) cylinder(r=w/2,h=8*w);
        }
        translate([q,0,-q]) linear_extrude(height=8*q) //Tube hole and slot.
        {   circle($rt);
            translate([4*q,0]) square([8*q,1.8*$rt],center=true);
        }
        translate([q,0,-q]) 
        {   linear_extrude(height=1.5*$rt) //nut space and slot.
            {   circle(2*$rt);
                translate([4*$rt,0]) square([8*$rt,4*$rt],center=true);
            }
            translate([0,0,$rt]) cylinder(r1=2*$rt,r2=$rt,h=$rt); 
        }
        translate([q,0,-4*q]) cylinder(r=$r,h=8*q); //Filament hole.
        translate([5.7*q,0,]) cube(q*[8,8,8],center=true);
    }
}

//Block slides in the slider(addition and substraction to combine with other things)
module slider_add()
{   //Main block shape.
    linear_extrude(height=phh) square((phw+2*pht+2*s)*[1,1],center=true);
    linear_extrude(height=dz+2*t)  //'shoulders' with springs in them go here.
    {   square([2*ds,2*sR+2*t],center=true);
        for(a=[0,180]) rotate(a) translate([ds,0]) circle(sR+t);
    }
    translate([0,2*sR+t,phh+q]) rotate(90) tube_holder();
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
    //Slot for wing.
    translate([-t/4,0,-t]) cube([t/2,8*q,phh-2*q+2*t]);
}

//Single loose slider.
// Nothing designed to hold anything on to anything, if you want to add
// something to an existing design, use `slider_sub` and slider_add manually
// in a way that doesnt hamper its function.
module slider()
{
    difference()
    {   slider_add();
        slider_sub();
    }
}

//slider();

module as_assembled()
{
    color("red") translate([0,phw/2+pht,phh*$t/2]) pen_holder();
    mqf_double_pen_holder();
}

syr= 12+s; //Syringe radius.(it is pretty small.
sybr = 3;
fh = 1.2*(syr-sybr);

module syringe_add()
{
    cylinder(r=syr+pht,h=fh+t);
}
module syringe_sub()
{
    translate([0,0,-4*t]) cylinder(r=sybr,h=8*phh);
    cylinder(r1=sybr,r2=syr,h=fh+0.01*t);
    translate([0,0,fh]) cylinder(r=syr,h=phh);
}

//as_assembled();

//translate([0,-10]) cylinder(r=10,h=50);


//Mini quickfit holder
module mqf_double_pen_holder(secondary=0)
{
    intersection()
    {   union()
        {   translate([0,0,th/2]) cube([w,l,th],center=true);
            translate([0,phw/2+pht]) slider_add();
            rotate(180) if(secondary == 0){ translate([0,phw/2+pht]) slider_add(); }
            else if(secondary==1){ translate([0,syr]) syringe_add(); }
        }
        difference()
        {   union()
            {   cube([w,l,8*phh],center=true);
                translate([0,0,phh]) cube([2*w,2*l,phh],center=true);
            }
            translate([0,phw/2+pht]) slider_sub();
            rotate(180) if(secondary == 0){ translate([0,phw/2+pht]) slider_sub(); }
            else if(secondary==1){ translate([0,syr]) syringe_sub(); }
            //Two holes for air flow/wiring, plus holes for potential mounting.
            //(note: currently identical to j-head holder one)
            for(x=[l,-l]/2) translate([x,0]) 
            {   rotate(45) cube([w/6,w/6,l],center=true);
                for(y=[1,-1]*w/6) translate([0,y,-l]) cylinder(r=sr,h=3*l);
            }
        }
    }
}

module diamond_pen_holder()
{
     difference()
     {   slider_add();
         slider_sub();
     }
     linear_extrude(height=t/2) difference()
     {   
         for(x=[1,-1]*w/6) translate([x,0,-l]) cylinder(r=sr,h=3*l);
     }
     
}

//mqf_double_pen_holder(secondary=1);

use<../j-head-holder-n-pusher/j_head_holder.scad>;

color("red") translate([2*(phw-pht),-2*pht,th+0.1]) rotate(-90)
{   diamond_pen_holder();
    pen_holder();
}
jh_holder();

