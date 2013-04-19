//
//  Copyright (C) 18-04-2012 Jasper den Ouden. (ojasper.nl)
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

module stand_core()
{   h= sri;
    cylinder(r=sri,h=h);
    translate([0,0,h]) 
    {   spikes();
        translate([0,0,(uz+tz)/2+mr/2]) cube([ri,ri,uz+tz+2*mr],center=true);    
    }
}
stand_top();
translate([0,2*sro]) stand_core();
translate([2*(ri+3*mr+2*et),0]) marble_female_c(female_t_n=0, female_b_n=4);
