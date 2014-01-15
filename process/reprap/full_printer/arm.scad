//
//  Copyright (C) 08-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module bottom_arm2d(aR=aR+t)
{
    difference()
    {   translate([-aw,-aw]) square([ad+2*aw,3*aw]);
        translate([ad-aR-aw,0]) square([8*aR,aw]);
        translate([-ad,0]) square([ad+ar+aw,aw]);
    }
}

module bottom_arm()
{
    rotate([90,0,0]) intersection()
    {   linear_extrude(height=ah) bottom_arm2d();
        translate([0,4*aw,ah/2]) rotate([90,0,0]) linear_extrude(height=8*aw) difference()
        {   hull()
            {   translate([ah-aw,0]) circle(ah);
                translate([ad+aw-ah,0]) circle(ah);
            }
            circle(ah/4);
            translate([ad,0]) circle(ah/4);
        }
    }
}

module top_arm2d() //Profiled from other direction than the other one!
{
    n=6;
    difference()
    {   union()
        {   circle(aR+t);
            hull(){ circle(ah/2); translate([ad,0]) circle(ah/2); }
            hull(){ translate(aR*[1,-1]/sqrt(2)) circle(ah/4); 
                    translate([ad/2,0]) circle(ah/4); }
         }
        circle(ah/4);
        translate([ad,0]) circle(ah/4);
        difference() //Get it some spokes.
        {   circle(aR-aw);
            circle(ah/2);
            for(a=[0:360/n:360*(1-1/n)]) rotate(30+a) square([aw,aR]);
        }
    }
}
module top_arm()
{   difference()
    {   linear_extrude(height=aw) top_arm2d(); 
        rotate_extrude() translate([aR+t,aw/2]) circle(0.6*t); //Groove.
    }
}

translate([ad,0]) rotate(140*$t) top_arm();
translate([0,ah/2]) color("red") bottom_arm();
