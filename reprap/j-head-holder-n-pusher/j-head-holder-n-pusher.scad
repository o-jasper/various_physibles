//
//  Copyright (C) 21-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<nut.scad>

$fn=60;

echo(sr);

s=1;
//This is intended to attach to the j-head and press down a bowden tube for 1.75mm.

//J-Head small and large radius. //TODO get actual values!
jh_sr= 5; 
jh_lr= 8;
jh_sh= 5; //Slot height.

jh_rh=6;  //'rim height' top part ..

dd = 2; //j-head 'drops' this much.

quickfit=true;
w= 80; //100;
l= 40;
th=5;
//quickfit_s=0.5;

r = 3;
t=4;
d=max(5,jh_lr+t-r);

//Screws go into the smaller hole to push down at a widening of the pfte tube
module pusher() 
{
    linear_extrude(height=2*t) intersection()
    {
        scale([(r+d+t/2+2*sr)/(5*r),(r+t/2)/(5*r)]) circle(5*r);
        difference()
        {   scale([1,1/2]) circle(r+d+t+2*sr);
            circle(r);
            for( s=[1,-1] ) translate([s*(r+d+sr),0]) circle(sr);
        }
    }
}

module slide(r)
{
    d = 10*(jh_lr +t);
    union()
    {   circle(r);
        translate([d,0]) square(2*[d,r],center=true);
    }
}

module base()
{   linear_extrude(height = th) square([w,l],center=true); }

h=dd+2*jh_sh;
module holder_add(p,a)
{
    translate(p) rotate(a) linear_extrude(height = h) 
    {   circle(jh_lr+t);
        for(s=[1,-1]) translate([r+d+sr,0]*s) circle(sr+t/2);
        translate([0,jh_lr/2]) square((jh_sr+t/2)*[2,2],center=true);
    }
}
module holder_cut(p,a)
{
    q=t;
    translate(p+[0,0,-q]) rotate(a)
    {   rotate(90) linear_extrude(height=l) slide(jh_sr);
        for(s=[1,-1]) translate([r+d+sr,0]*s) 
                      {   cylinder(r=sr,h=l);
                          linear_extrude(height=t+nh) nut_profile(nt);
                      }
        linear_extrude(height=q+2*dd) rotate(90) slide(jh_lr);
       
        translate([0,0,q+dd+jh_sh]) cylinder(r=jh_lr, h=l);
        translate([0,0,q+2*dd+jh_sh]) 
            linear_extrude(height=l) rotate(90) slide(jh_lr);
    }
}

module single_holder() //(not supported)
{   p=[0,0,0];
    difference()
    {   union(){ base(); holder_add(p,0); }
        holder_cut(p,0);
    }
}

module dual_holder()
{   p=[0,jh_lr+t/4,0];
    difference()
    {   union(){ base(); holder_add(p,0);holder_add(-p,180); }
        holder_cut(p,0);
        holder_cut(-p,180);
        //Two holes for air flow/wiring, plus holes for potential mounting.
        // Might want to design a sucktion system and mayb
        for(x=[l,-l]/2) translate([x,0]) 
        {   rotate(45) cube([w/6,w/6,l],center=true);
            for(y=[1,-1]*w/6) translate([0,y,-l]) cylinder(r=sr,h=3*l);
        }
    }
}
//Thin sliver you can slide in if it is felt it is too  loose.
module sliver()
{   sz = l/2-jh_lr-t/4;
    intersection()
    {   union()
        {   linear_extrude(height=2*dd) slide(jh_lr);
            linear_extrude(height=2*dd+jh_sh) slide(jh_sr);
        }
        difference()
        {   cube([2*sz,2*jh_lr,l],center=true);
            translate([0,0,-t]) 
            {   cylinder(r=jh_lr,h=dd+t);
                linear_extrude(height=l) rotate(180) slide(jh_sr);
            }
            translate([-jh_lr,0]) cube([3*jh_lr,8*jh_lr,2*dd],center=true);
            translate([0,0,jh_sh+th-2*dd]) cylinder(r=jh_lr,h=l);
        }
    }
}

module printable()
{
    dual_holder();
    translate([0,l/2 + jh_lr+t]) sliver();
    translate([0,-l/2 - jh_lr-t])pusher();
}

module show()
{
    x=jh_lr+t/4;
    translate([0,x,h+t]) pusher();
    dual_holder();
    translate([0.1,x+0.1,0.1]) rotate(90) ///rotate([180,0,0]) 
    {   color([0,0,1]) sliver();
        translate([0,0,dd]) color([0,1,0]) cylinder(r=jh_sr,h=jh_sh);
    }

}

show();
//sliver();
//printable();


