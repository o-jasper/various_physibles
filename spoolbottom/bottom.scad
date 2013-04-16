//
//  Copyright (C) 15-04-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

ri = 31/2;
ro = 1.7*ri;
h = ro/2;

t= ri/4;

inf=3*ro;
//bows_p=false; //TODO ''bridges' instead of bows..
// Decreases height, materials, difficulty..

module a_bow()
{   rotate([90,0]) scale([1,3]) rotate_extrude() translate([ri-t,0]) circle(t); }

module bows()
{
    difference()
    {
        union()
        {   a_bow();
            rotate(90) a_bow();
        }
        translate([0,0,-inf]) cube(2*inf*[1,1,1],center=true);
        cylinder(r1=ri-t/2,r2=ri-t, h=h);

        scale([1,1,(3*ri-t)/(ri-t)]) sphere(ri-t);
    }
}

//TODO holes (as for instance backup.
module bottom()
{
    difference()
    {   union()
        {   cylinder(r1=ri, r2=ro, h=h-t/2);
            translate([0,0,h-t/2]) cylinder(r=ro, h=t/2);
        }
        translate([0,0,-inf]) cube(2*inf*[1,1,1],center=true);
        cylinder(r1=ri-t/2,r2=ri-t, h=h);
        
        translate([0,0,h+inf]) cube(2*inf*[1,1,1],center=true);
    }
    bows();
}

//bottom();

//translate((2*ro+t)*[1,0]) bottom();

mr= 13.4;
md = mr/2;

module top()
{
    t=2*t;
    rl = mr/sqrt(2)+2*t;
    mz = t+rl/2 + (mr-md)/sqrt(2);
    difference()
    {   union()
        {   cylinder(r1=ri+rl-t,r2=ri+rl,h=t);
            translate([0,0,t]) cylinder(r1=ri+rl,r2=ri,h=rl);
            translate([0,0,t+rl]) 
            {   cylinder(r=ri, h=t);
                bows();
            }
        }
        cylinder(r2=ri-t/2,r1=ri+t, h=2*t+rl);
        rotate_extrude() translate([ri+rl/2 + (mr-md)/sqrt(2),mz]) circle(mr);
    }
    
}

module roller()
{
    
}

top();
