//
//  Copyright (C) 18-09-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<nut.scad>

echo(sr);

//This is intended to attach to the j-head and press down a bowden tube for 1.75mm.

//J-Head small and large radius. //TODO get actual values!
jh_sr= 5; 
jh_lr= 10;
jh_sh= 5; //Slot height.

r = 2;

th=7;
t=5;
d=max(5,jh_lr+t-r);

dd = 1;

//Screws go into the smaller hole to push down at a widening of the pfte tube
module pusher() 
{
    linear_extrude(height=th) intersection()
    {
        scale([(r+t)/(5*r),(r+d+t+2*sr)/(5*r)]) circle(5*r);
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

function five (x) = floor(x/5)*5+5;

w= five(2*(jh_lr+t));

//Holds the j-head by its slot.
module holder()
{
    l= five(2*(r+d+2*sr+t));
    h= five(3*jh_sh);
    
    echo(w,l,h);
    
    difference()
    {   linear_extrude(height = h) difference()
        {   square([w,l],center=true);
            //TODO figure the distance between these things.
            for(s=[[1,1],[-1,1],[1,-1],[-1,-1]]) scale(s) translate([w/2-5,l/2-5]) circle(sr);
        }
        for( s=[1,-1] ) translate([0,s*(r+d+sr),-t])
                        {   cylinder(r=sr, h=4*h);
                            linear_extrude(height= t+nh) rotate(30) nut_profile(nt);
                            }
        translate([0,0,-2*jh_sh]) slide(jh_lr);
        translate([0,0,2*jh_sh]) slide(jh_lr);
        translate([0,0,2*jh_sh-dd]) cylinder(r=jh_lr,h=jh_sh); //As it is tightened, it drops into a little hole.
        slide(jh_sr);
    }
}

//Thin sliver you can slide in if it is felt it is too  loose.
module sliver()
{
    intersection()
    {   slide(jh_lr,dd);
        difference()
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
