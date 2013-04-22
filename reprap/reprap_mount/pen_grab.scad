//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use <rounded_box.scad>

//These three variables are supposed to be somewhat standard.
hw = 20; //Holding size.
hl = 5; //Holding bar length.
r  = 2.5;

ft= 5;
pr= 10/2;  //Pen radius.
pf = 0.9; //Factor less space to take so it clamps. 
h= 19.4; //Height.

t = 6;
a=40;

module grabber(h)
{
    h = h<0 ? 2*pr/sin(a) : h;
    linear_extrude(height=h) difference()
    {   circle(r);
        translate([2*r,0]) circle(2*r);
    }
}

n = 4; m =4;

ph = (m-0.5)*t-r*cos(a);//Pillars height.
th = h + 2*pr/sin(a); //total height

module pen_grab()
{    
    intersection()
    {   union()
        {   linear_extrude(height=ph) difference()
            {   translate([-hw/2,-hw/2]) rounded_square(hw,hw, r);
                translate([r-hw/2,r-hw/2]) rounded_square(hw-2*r,hw-2*r, r);
            }
            for( i = [0:n-1] )
                rotate(45+i*360/n) translate([hw/2,0]) 
                {   grabber(ph);
                    for( j =[0:m-1] )
                        translate([0,0,j*t]) rotate([0,-a]) grabber(-1);
                }
        }
        difference()
        {   translate([0,0,th/2]) cube([hw+2*r,hw+2*r,th], center=true);
            cylinder(r= pf*pr, h=10*h);
        }
    }
}

include<attachable.scad>

module pen_grab_component()
{
    pen_grab();
    difference()
    {   attach_methods(1.2, 1,1);
        cube([hw,hw, 10*hl], center=true);
    }
}

pen_grab_component();
