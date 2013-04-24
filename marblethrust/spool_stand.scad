//
//  Copyright (C) 18-04-2013 Jasper den Ouden. (ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

mr= 15/2; //Radius of marbles.
ri = 5; //Radius of pole.
et = 1;  //Thickness of edge.
uz = 5; //Height of bottom plate.
ur = 0; //Radius at bottom

male_n = 2; //Connecting holes on plate ontop.
tz= 0;

female_b_n = 0; //Connecting holes on bottom.(choose 4 if you use it.)
female_t_n = 4; //Connecting holes on top.
female_t_hole = true;

use<marblethrust.scad>
use<marblethrust_component.scad>

sri = 31/2;
sro = 1.5*sri;

shr = 1.1*sro; //Stand helper radius.
shh = uz+2*mr+ et; //..height.

module spikes(s)
{   n=8;
    for( i= [1:n] ) rotate(i*360/n) translate([3*sri/4,0]) cylinder(r=sri/8,h=uz/2); 
}

module stand_top()
{   difference()
    {   marble_male(ri,mr, uz,sro,tz,et);
        cube(ri*[1,1,1000],center=true);
        spikes();
    }
}

module stand_bottom()
{   marble_female_c(female_t_n=0, female_b_n=4); }

module stand_core()
{   h= sri;
    cylinder(r=sri,h=h);
    translate([0,0,h]) 
    {   spikes();
        translate([0,0,(uz+tz)/2+mr/2]) cube([ri,ri,uz+tz+2*mr],center=true);    
    }
}

module stand_vert()
{
    r = (shr-2*ri)/2;
    rotate([90,0]) translate([ur+1.5*ri+shr/2,0,-ri/2])
        linear_extrude(height = ri) difference()
    {   union()
        {   square([shr-uz,shh]);
            translate([shr-uz,0]) circle(uz);
        }
        translate([shr-uz,-2*uz]) square(4*uz*[1,1], center=true);
        translate([0,shh]) scale([1,(shh-uz)/r]) circle(r);
        translate([shr-uz,shh]) scale([1,(shh-uz)/r]) circle(r);
    }
}
//It is all a bit small so it may need some help not falling over.
// Doesnt really seem a problem so far so you may try not printing it.
module stand_helper()
{   ro = et+ri+2*mr;
    ur = max(ur,1.2*(ro-uz));
    
    difference()
    {   union()
        {   cylinder(r= ur + 1.25*ri, h=uz+ri/2);
            rotate(45) stand_vert();
            rotate(135) stand_vert();
            rotate(225) stand_vert();
            rotate(315) stand_vert();
        }
        cylinder(r=ro,h=3*uz);
        rotate(45) stand_bottom();
    }
}

module as_print_all()
{   stand_top();
    translate([0,2*sro]) stand_core();
    translate([2*(ri+3*mr+2*et),0]) stand_bottom();
    translate([0,-shr-sro-ri]) stand_helper();
}

as_print_all();
