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
pen_holder_wires = true;

with_holes=true;

module teardrop(r) //Look at the MCAD version.. MCAD needs to simplify their shit.
{   circle(r);
    translate([-r/sqrt(2),0]) rotate(45) square([r,r],center=true);
}

module pen_holder()
{
    linear_extrude(height=phh) difference() 
    {   square([phw,phw],center=true);
        difference()
        {   square((phw-2*pht)*[1,1],center=true);
            for(x=[-pd,pd]/2) translate([x,0]) square([pfmt,phw],center=true);
        }
    }
    //Flap you put a clamp on to control it with a filament.
    if(pen_holder_wires) for(a=[0,-90,180]) rotate(a)
        translate([phw/2-pht,0,phh]) rotate([0,90,0]) rotate(90)
            linear_extrude(height=pht) difference()
            {   union()
                {   square([4*sr,phw/2],center=true);
                    translate([0,phw/4]) rotate(-90) circle(2*sr);
                }
                translate([0,phw/4]) rotate(-90) teardrop(sr);
            }
    if(clamping_flap) difference()
    {   linear_extrude(height=6*sr) translate([-t/4+s,phw/2]) square([t/2-2*s,3*t+sr]);
     //Hole for screw. Might later add something that screws on here to clamp on the
     // filament.
        translate([-4*t,phw/2 + 2*t+sr/2,t+sr]) rotate([0,90,0]) 
            linear_extrude(height=8*t) teardrop(sr);
    }
}

$r = 2/2; // radius of filament(accounted, actually made a bit bigger than needed)
$rt = 1.75; //Tube radius

q= 2*$rt+t/2;
module tube_hole_and_slot()
{   linear_extrude(height=8*q) //Tube hole and slot.
    {   circle($rt);
        translate([4*q,0]) square([8*q,1.8*$rt],center=true);
    }
}
module spring_holder(sub=true,s=0)
{
    l=4*q; wtop = q/1.5; h=1.5*t;
    difference()
    {   hull()
        {   translate([-q,0]) cube([2*q+s,l,t/16]);
            translate([-wtop/2,0,h-t/16]) cube([wtop+s,l,t/16]);
        }
        if(sub) translate([0,0,-t]) 
        {   translate([0,l-q]) rotate(90) tube_hole_and_slot();
            translate([0,q]) cylinder(r=sR,h=8*q);
        }
    }
}

translate([0,w]) spring_holder();
//Tube holder bit(not a separate part)
module tube_holder()
{
    d=1.5*q;
    w=2*(2*$rt+t);
    difference()
    {   //Main shape.
        translate([0,w/2]) rotate([90,0,0]) linear_extrude(height=w) 
        {   polygon([[0,-w/2], [0,1.5*t], [w,1.5*t],
                     [w,-w/2], [0,-3*w/2]]);
        }
        translate([d,0,-q]) 
        {   tube_hole_and_slot();
            linear_extrude(height=1.5*$rt) //nut space and slot.
            {   circle(2*$rt);
                translate([4*$rt,0]) square([8*$rt,4*$rt],center=true);
            }
            translate([0,0,$rt]) cylinder(r1=2*$rt,r2=$rt,h=$rt); 
            translate([0,0,-8*q]) cylinder(r=$r,h=8*q); //Filament hole.
        }
    }
    translate([phw/2-2*sR-t,0,-2*q]) rotate([0,90,0]) 
        linear_extrude(height=pht) 
        intersection()
    {   scale([5,1]) rotate(45) square((phw-pht)*[1,1],center=true);
        square([5*q+t/16,phw+2*pht],center=true);
    }
}

//Block slides in the slider(addition and substraction to combine with other things)
module slider_add()
{   
    f=1.2;
    step = f*(phw-2*pht)/sqrt(2)+t;
//Main block shape.
    difference()
    {   linear_extrude(height=phh) square((phw+2*pht+2*s)*[1,1],center=true);
        if(with_holes) for(z=[th+step:step:phh-step]) translate([0,0,z])
            scale([1,1/f,1]) rotate([45,0,0]) cube([8*l,step,step],center=true);
    }    
    //holds the tube.
    translate([0,2*sR+t,phh+2*q]) rotate(90) tube_holder();
}

module slider_sub()
{
    q=2*sR+t/4+s;
    // Sliding of square part.
    cube((phw+2*s)*[1,1,0]+[0,0,8*phh],center=true);
    //Slot for wing.
    translate([-t/4,0,-t]) cube([t/2,8*q,phh]);
    //Slot for spring pusher/
    translate([0,2*sR+t,phh+q+2*t]) spring_holder(sub=false,s=0.3);
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
    color("red") translate([0,phw/2+pht,(phh+th)*$t/2]) pen_holder();
    mqf_double_slider(secondary=secondary);
//    color("blue") translate([0,0.8*q+2*sR+t,phh+2*q-t/2]) spring_holder();
}

syr= 12+s; //Syringe radius.(it is pretty small.
sybr = 3;
fh = 1.2*(syr-sybr);

module syringe_add()
{
    h=(fh+t+phh)/2; q= (phh-h);
    cylinder(r=syr+pht,h=fh+t);
    intersection()
    {   cylinder(r=syr+pht,h=phh);
        difference()
        {   hull()
            {   translate([0,0,t]) cube(2*[2*syr,sybr/4,1],center=true);
                translate([0,0,phh]) cube(2*[2*syr,syr+t,1],center=true);
            }
            translate([0,0,h]) rotate([45,0,0]) cube([8*syr,q,q],center=true);
        }
    }
}
module syringe_sub()
{
    translate([0,0,-4*phh]) cylinder(r=sybr,h=8*phh);
    translate([0,0,-2]) //Note: the syringe will need about ~2cm of extra length.
    {   cylinder(r1=sybr,r2=syr,h=fh+0.01*t);
        translate([0,0,fh]) cylinder(r=syr,h=8*phh);
    }
}

//Mini quickfit holder
module mqf_double_slider(secondary=0)
{
    d=phw/2+pht+t;
    pulley_h=fh+t;
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
            if( secondary==0 ) for(x=[l,-l]/2) translate([x,0]) 
            {   rotate(45) cube([w/6,w/6,l],center=true);
                for(y=[1,-1]*w/6) translate([0,y,-l]) cylinder(r=sr,h=3*l);
            }
            else
            {   for(x=[l,-l]/1.8) translate([x,0]) 
                   for(y=[1,-1]*w/8) translate([-w/12,y-w/12,th/4]) cube([l/3,w/6,8*w]);
            }
        }
    }
    if(secondary==1) //Things to put (todo whatsitcalled) on.
    {
        for(x=[-d-3*t,-d,d,d+3*t]) translate([x-t/2,0,pulley_h]) 
            rotate([0,90.0]) linear_extrude(height=t) difference()
            {   union()
                {   circle(3*sr);
                    translate([pulley_h/2,0]) square([pulley_h,6*sr],center=true);
                }
                teardrop(sr);
            }
    }

}

module mqf_syringe_n_slider()
{   mqf_double_slider(secondary=1); }

//Not sure of use
module filament_holder() 
{
    difference()
    {   rotate([0,-90,0]) linear_extrude(height=1.2*t) intersection()
        {   square(t*[3,10]);
            difference()
            {   translate(t*[1.5,2.5]) circle(2.5*t);
                translate(t*[1.5,1.5]) rotate(180) teardrop(sr);
            }
        }
        translate([-0.6*t,0,-t])
        {   cube([1.75,8*t,9*t],center=true);
            translate([0,4*t]) cylinder(r=1.75/2,h=8*t);
        }
        
    }
}

translate([w,0]) filament_holder();

/*mqf_double_pen_holder(secondary=1);

use<../j-head-holder-n-pusher/j_head_holder.scad>;

color("red") translate([2*(phw-pht),-2*pht,th+0.1]) rotate(-90)
{   diamond_pen_holder();
    pen_holder();
}
jh_holder();*/

as_assembled(secondary=1);
