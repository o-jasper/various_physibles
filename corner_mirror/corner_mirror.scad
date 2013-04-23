//
//  Copyright (C) 23-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use<rounded_box.scad>

hl = 80; //Length of handle.
l = 20; //Length of mirror reinforced.
mt = 2; //thickness of mirror.
t=3*mt;
r=t; //Rounding.
s=t/2; //'Level of enclosing'

//sr= 1.2; 

module _mirror_corner()
{
    difference()
    {   linear_extrude(height=t) rounded_square(l,l,t, r);
        translate([s,s,mt]) cube([l,l,mt]);
        translate([2*s,2*s,mt]) cube([mw-2*s,ml-2*s,3*t]);
        translate([l,l]) cylinder(r=l/2, h=t);
    }
}

module attacher()
{
    rotate([90,0,0]) translate([l/2,0,-t/3]) linear_extrude( height=t/3 ) difference()
    {   union() 
        {   square([l/2+t/2,t]);
            translate([l/2+t/2,t/2]) circle(2*t/3);
        }
        translate([0,t/4]) square([l/2+t/2,t/2]);
        translate([l/2+t/2,t/2]) circle(t/4);
        translate([0,-2*l]) square(4*[l,l], center=true);
        translate([0,t+2*l]) square(4*[l,l], center=true);
    }
}

module mirror_corner()
{
    _mirror_corner();
    attacher();
    translate([t/3,0]) rotate(90) attacher();
}

module mirror_stick_corner()
{   
    difference()
    {   union() 
        {   mirror_corner();
            difference()
            {   translate([r,r,t/2]) rotate(-45)
                {   rotate([90,0,0]) cylinder(r=2*t/3,h=2*hl/3);
                    translate([0,-hl/2]) scale([1,(hl-t)/(2*t),1]) sphere(t);
                    translate([0,-0.9*hl]) scale([1,(0.1*hl)/t,1]) sphere(t);
                }
                translate([r,r,0]) rotate(-45) translate([0,-0.9*hl]) scale([1,1.5,1]) 
                {   cylinder(r1=0.6*t,r2=0.4*t, h=t);
                    cylinder(r2=0.6*t,r1=0.4*t, h=t);
                }
                translate([0,0,-2*hl])  cube(hl*[4,4,4], center=true);
                translate([0,0,t+2*hl]) cube(hl*[4,4,4], center=true);
            }
            linear_extrude(height=t) polygon([[-hl/8,-hl/8],[0,l/2],[l/2,0]]);
        }
        cylinder(r=t/3,h=t);
        translate([s,s]) linear_extrude(height=t) polygon([[0,0],[0,l/2],[l/2,0]]);
    }
}
mirror_stick_corner();
//rotate([0,-90,0]) mirror_corner();
