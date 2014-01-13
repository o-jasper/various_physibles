//
//  Copyright (C) 19-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<rounded_box.scad>
use<infi.scad>

t= 5;
sw = 42.5;//Width and height of stepper.
ssw = 32; //Smaller width and height of stepper.
ssl = 10.8; //How 'long' the indentation goes.
gl = 40; //Length of guide.
gw = 10; //Width of guide(the hole)
gr = 0.6*t;

inf = 3*ssw;

gcw = 3; //Width of cut to get wire to guide.(equal to gw, but recommend not.

module round_stepper_profile()
{   d = (sw-ssw)/2;
    difference() 
    {   minkowski()
        {   translate([t+d,t+d]) square([sw-2*d,sw-2*d]);
            circle(t+d);
        }
        translate([t,t]) 
            polygon([[d,0],[0,d],         [0,sw-d], [d,sw],
                     [sw-d,sw],[sw,sw-d], [sw,d],[sw-d,0]]);
    }
}

module x_stepper_filguide()
{
    
    linear_extrude(height=ssl) difference()
    {   union()
        {   round_stepper_profile();
            translate([sw/2,sw/2]) rotate(135) translate([-gw/2,(sw+gw)/2]) scale([1,2])
            {   circle((gw-gcw)/2);
                translate([gw,0]) circle((gw-gcw)/2);
            }
        }
        translate([t+sw/2,1.5*sw]) square([t,inf], center=true);
        translate([sw/2,sw/2]) rotate(135) translate([0,sw]) 
            square([gcw,2*sw], center=true);
    }
    difference()
    {   translate([1.5*t,1.5*t,ssl/2]) rotate(-45) rotate([90,0]) scale([1,4*ssl/(7*gr)])
        {   translate([gr-gw,0]) cylinder(r=gr, h=gl-gw/2-gr);
            translate([gw-gr,0]) cylinder(r=gr, h=gl-gw/2-gr);
            rotate([90,0]) translate([0,gl-gw/2-gr])
                difference()
            {   rotate_extrude() translate([gw-gr,0]) circle(gr);
                inficube([0,-inf], inf=inf);
            }
        }
        inficube([0,0,-inf], inf=inf);
        inficube([0,0,inf+ssl], inf=inf);
    }
}

x_stepper_filguide();
