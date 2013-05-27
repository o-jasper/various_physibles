//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// Rounded plate, for instance for reinforcement on other side if the wall is thin.

h = 100;
w = 2*50;

//TODO feh doesnt seem easily solvable to get some angle _and_ some thickness at same time.
//t = 15;

r = 15; //Rounding radius.

corner_d = w/4;

a = 70; //Angle the sides 'hit' the end.

ox = r*cos(a);
oy = r*sin(a);

t= r - ox;

hole_r = w/32;
head_r = w/16; //Radius of screw(or whatever) head.
head_d = t/3; //Depth of embedding.
head_dr = w/32;
head_dz = t/6;

module rounded_plate_unsubstracted()
{   
    translate([0,w]) rotate(v=[1,0,0], a=90) 
    {   linear_extrude(height=w-2*oy)
        {   circle(r);
            translate([0,h/2-oy]) square([2*r,h-2*oy], center=true);
            translate([0,h-2*oy]) circle(r);
        }
        sphere(r);
        translate([0,h-2*oy]) sphere(r);
        translate([0,0,w-2*oy]) sphere(r);
        translate([0,h-2*oy,w-2*oy]) sphere(r);
    }
    translate([0,w]) cylinder(h=h-2*oy, r=r);
    translate([0,2*oy]) cylinder(h=h-2*oy, r=r);
}

module substract_hole() //TODO use the nut_hole file.
{   rotate(v=[0,1,0], a=90) 
    { cylinder(r= hole_r, h = 4*r);
      cylinder(r=head_r, h=r+head_d);
      cylinder(r1=head_r + head_dr*(r + head_dz)/head_dz, r2=head_r, 
               h= r+head_dz);
    }
}
module rounded_plate()
{
    difference()
    {   translate([0,-r,oy]) difference() 
        {   translate([ox,r - oy]) rounded_plate_unsubstracted();
            translate([r,w/2,h/2]) cube(2*[r,2*w,h], center=true);
        }
        translate([ox-2*r,corner_d,corner_d]) substract_hole();
        translate([ox-2*r,w-corner_d,corner_d]) substract_hole();

        translate([ox-2*r,corner_d,h-corner_d]) substract_hole();
        translate([ox-2*r,w-corner_d,h-corner_d]) substract_hole();
    }
}

rounded_plate();
color([0,0,1]) translate([30,0]) cube([10,w,h]);
