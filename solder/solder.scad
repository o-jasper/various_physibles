//
//  Copyright (C) 25-05-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<can.scad> //NOTE preview doesnt show can() well.

sa = 40; //Angle of soldering iron.

//Bottom thickness.
bt= 14; 
//Radial thickness.
rt=2;
//Number of times round.
n= 6;
//Sizeof pips.
pr=7;
//Size of guides.
sr=1;

can_tty=15; //Top bevel height.

sol = 10;

module can_substract()
{   union()
    {   can();
        cylinder(r=can_r-3*can_tx/4,h=can_r);
    }
}

module can_end(wire_end=false)
{
    intersection()
    {   union()
        {   cylinder(r=can_r+rt, h=bt); //Main shape.
            for(a=[0:360/n:360]) rotate(a) //Pips on the wires.
               translate([can_r,0,bt]) sphere(pr);
        }
        difference()
        {   translate([0,0,bt]) scale([1,1,2*bt/(can_r+rt)]) sphere(can_r+rt); //Round it.
            can_substract(); //Hole for can.
            for(a=[0:360/n:360]) rotate(a) union() //Holes for wires.
            {   for( y=sr*[-2,2] ) translate([can_r,y,bt-pr]) 
                {   cylinder(r=sr,h=bt);
                    sphere(sr);
                    rotate([0,140]) cylinder(r=sr,h=bt);
                }
                if( wire_end )//Place to put wire end.(NOTE hole too big
                {   translate([can_r+rt,0]) scale([4,2]) cylinder(r=sr, h=bt);
                    translate([can_r+rt,0,bt]) scale([4,2,2]) sphere(sr);
                }
            }
            
        }
    }
}

module attachment_plate()
{
    difference()
    {   linear_extrude(height=bt/2) union() for( a = [-60,60] ) rotate(a) difference()
        {   union()
            {   translate([-sol,0]) square([2*sol,can_r+rt+sol]);
                translate([0,can_r+rt+sol]) circle(sol);
            }
            translate([0,can_r+rt+sol]) circle(sol/2);
        }
        can_substract(); //Hole for can.
    }
}

module bottom_end()
{
    union()
    {   can_end();
        attachment_plate();
    }
}

/*module top_end()
{
    union()
    {   can_end();
        difference()
        {   translate([0,can_r,bt]) rotate([-sa,0]) translate([0,0,-pr]) difference()
            {   union()
                {   cylinder(r=pr, h=3*pr);
                    translate([0,0,3*pr]) sphere(pr);
                }
                translate([0,0,0]) cube([pr,6*pr,9*pr], center=true);
                for( z=pr*[1.5,2,2] ) translate([-3*pr,0,z]) 
                                            rotate([0,90,0]) cylinder(r=sr,h=6*pr);
                translate([-3*pr,0,3*pr])
                    rotate([0,90,0]) cylinder(r=pr/2,h=6*pr);
            }
            can();
        }
    }
} */
//top_end();
bottom_end();

sbh = 3;

module stand()
{
}
