//
//  Copyright (C) 18-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<nut.scad>

$fs=0.1;

echo(sr);

//This is intended to attach to the j-head and press down a bowden tube for 1.75mm.

//J-Head small and large radius. //TODO get actual values!
jh_sr= 5; 
jh_lr= 8;
jh_sh= 5; //Slot height.

jh_rh=6;  //'rim height' top part ..

r = 3;

th=7;
t=4;
d=max(5,jh_lr+t-r);

dd = 2;

//Screws go into the smaller hole to push down at a widening of the pfte tube
module pusher(h=th) 
{
    linear_extrude(height=h) intersection()
    {
        scale([(r+t)/(5*r),1.2*(r+d+t+2*sr)/(5*r)]) circle(5*r);
        difference()
        {   circle(r+d+t+2*sr);
            circle(r);
            for( s=[1,-1] ) translate([0,s*(r+d+sr)]) circle(sr);
        }
    }
}

module slide(r, h=3*jh_sh)
{
    d = 10*(jh_lr +t);
    linear_extrude(height=h)
    {   circle(r);
        translate([d,0]) square(2*[d,r],center=true);
    }
}

//Rounds upwards to five mm-dividable units.
function five (x) = floor(x/5)*5+5;

w= five(2*(jh_lr+t));

//Holds the j-head by its slot.
module holder()
{
    l= five(2*(r+d+2*sr+t));
    h= five(3*jh_sh);
    
    echo(w,l,h);
    
    difference()
    {   
        union()
        {   linear_extrude(height = th) difference()
            {   minkowski()
                {   square([w-10,l-10],center=true);
                    circle(5);
                }
                for(s=[[1,1],[-1,1],[1,-1],[-1,-1]]) scale(s) translate([w/2-5,l/2-5]) circle(sr);
            }
            intersection()
            {   union()
                {   slide(jh_lr+t,h=h);
                    pusher(h=h);
                }
                cube([w,l,5*h],center=true);
            }
        }
        for( s=[1,-1] ) translate([0,s*(r+d+sr),-t])
                        {   cylinder(r=sr, h=4*h);
                            linear_extrude(height= t+nh) rotate(30) nut_profile(nt);
                            }
        translate([0,0,-2*jh_sh]) slide(jh_lr);
        translate([0,0,2*jh_sh]) slide(jh_lr,h=jh_sh+t/2);
        
        translate([0,0,2*jh_sh-dd]) cylinder(r=jh_lr,h=jh_rh); //As it is tightened, it drops into a little hole.
        slide(jh_sr); //Hole for smallest diameter of j-head.
        //Hole for pfte tube.
        translate([0,0,2*jh_sh]) slide(r,h=4*h);
    }
}

//Thin sliver you can slide in if it is felt it is too  loose.
module sliver()
{
    intersection()
    {   slide(jh_lr,h=dd);
        linear_extrude(h=dd) difference()
        {   square([w,w],center=true);
            circle(jh_sr);
            translate([-d,0]) square(2*[d,jh_sr],center=true);
        }        
    }
}

module show()
{
    pusher();
    translate([w,0]) sliver();
    translate([-w,0]) holder();
}

show();