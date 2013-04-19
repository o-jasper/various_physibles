//
//  Copyright (C) 18-04-2012 Jasper den Ouden. (ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<marblethrust.scad>
use<marblethrust_component.scad>

mr= 15/2; //Radius of marbles.
ri = 5; //Radius of pole.
et = 1;  //Thickness of edge.
uz = 5; //Height of bottom plate.
ur = 0; //Radius at bottom

male_n = 2; //Connecting holes on plate ontop.

female_b_n = 0; //Connecting holes on bottom.(choose 4 if you use it.)
female_t_n = 4; //Connecting holes on top.
female_t_hole = true;

inf= 100*mr;

sri = 31/2;
sro = 1.5*sri;
ct = 4; //Thickness of cap/

tz= 2*et +2*ct + 2*ri*male_n; //Height thing.(overridden here)

module spool_cap()
{
    difference()
    {   union()
        {   cylinder(r1= sro - ct/2, r2 = sro, h=ct/2);
            translate([0,0,ct/2]) cylinder(r = sro, h=ct/2);
            cylinder(r=sri, h=2*ct);
        }
        translate([0,0,-ct]) cylinder(r=sri-ct, h=4*ct);
    }
    translate([0,0,ct/2]) cube([2*(sri-ct),ct,ct],center=true);
}

module gravestone()
{
    w = 2*ri;
    rotate([90,0]) linear_extrude(height=ri)
    {   circle(2*ct);
        translate([0,ri*male_n-w/4]) square([w,2*ri*male_n-w/2], center=true);
        translate([0,2*ri*male_n-w/2]) circle(w/2);
    }
}

module spool_top_cap()
{
    difference()
    {   union()
        {   cylinder(r1= sro - ct/2, r2 = sro, h=ct/2);
            translate([0,0,ct/2]) cylinder(r = sro, h=ct/2);
            cylinder(r=sri, h=2*ct);
        }
        cylinder(r=ri, h=2*ct);
    }
    translate([0,0,2*ct]) difference()
    {   union()
        {   translate([0,-ri/2]) gravestone();
            translate([0,3*ri/2]) gravestone();
        }
        for( i=[0:male_n] )
            translate([0,10*ri,ri+2*ri*i]) rotate([90,0]) cylinder(r=ri/2,h=20*ri);
    }
}

module spool_hook()
{
    
}

module as_print()
{
    d=2*(ri+3*mr+2*et);
    marble_male_c(tz=tz);
    translate([d,0]) marble_female_c();

    translate([-d,0]) spool_top_cap();
    translate([-d,d]) spool_cap();
//   spool_hook(); //So need this.
//   spool_cap();
//   spool_
}

as_print();
