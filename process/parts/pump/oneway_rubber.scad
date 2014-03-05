//
//  Copyright (C) 05-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.05;

bt=1; //DONT FORGET TO CHECK ACTUAL
bw=7;

t=2;
r=bw/2+t/2;
l=10;

slot_r=bw/8;

module slit()
{
    hull() translate([0,0,-t]) for(y=[r-slot_r,-r/2+1.5*slot_r]) 
        translate([0,y]) cylinder(r=slot_r,h=l);
}

module oneway_cut()
{
    translate([0,0,l/2+bt/2]) cylinder(r=r,h=l); //From top.
    slit(t=t,bw=bw,r=r,l=l);
    hull()
    {   slit(t=t,bw=bw,r=r,l=l/2);
        translate([0,0,-t-r]) cylinder(r=r,h=l/2);
    }
  //indentation for the rubber band.
    translate([0,0,l/2]) linear_extrude(height=bt)
    {   translate([0,r+t]) square([bw,4*r],center=true);
        intersection(){  square([bw,8*r],center=true); circle(r); }
    }
}

ds=1;
module rubber_oneway_lone(f=1)
{   difference()
    {   intersection()
        {   hull() for(z=[f*t,l-f*t]) translate([0,0,z]) sphere(r+t);
            cylinder(r=r+t,h=l); //Main shape
        }                           
        oneway_cut(t=t,bt=bt,bw=bw,r=r,l=l);
        difference()
        {   translate([0,r+t,5*l/8]) cube([bw,bw,l/4],center=true);
            cylinder(r=r+t-bt*0.7,h=l);
        }
    }
    rotate_extrude()  intersection()
    {  //Thinning on both sides
        union() for(z=[ds,l-ds]) translate([r,z]) scale([1,1.5]) circle(ds);
        translate([0,l/2]) difference()
        {   square([2*(r+t),l],center=true);
            square([2*r,l-2*ds],center=true);
        }
    }
}

module rubber_oneway_lone_cover(s=0.2)
{   linear_extrude(height=0.8*l) difference(){ circle(r+s+1.5*t); circle(r+t+s); } }

module show(with_cover=false,split=true)
{   intersection()
    {   union()
        {   rubber_oneway_lone();
            if(with_cover) color("blue") rubber_oneway_lone_cover();
        }
        if(split) translate([-r/2,-4*l]) cube(l*[8,8,8]);
    }
}
//show(with_cover=true);
