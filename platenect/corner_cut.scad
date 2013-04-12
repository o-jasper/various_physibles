//
//  Copyright (C) 12-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<../lib/rounded_box.scad>

inf = 100;
t = 7;
tx= t;
ty= t;
tz= t;
r=  1.2*t;
wall_t=10; //Wall thickness.
wall_tx= wall_t;
wall_ty= wall_t;
wall_tz= wall_t;

corner_dx = 4*t;
corner_dy = 4*t;
screw_r  = 20;
screw_ir = 2;

dx = tx + max(wall_tx + 2*screw_r, 2*corner_dx);
dy = ty + max(wall_ty + 2*screw_r, 2*corner_dy);
dz = tz + max(wall_tz + 2*screw_r, 2*corner_dy);

module walls()
{
    difference()
    {   cube(inf*[1,1,1]);
        translate([wall_t,wall_t,wall_t]) cube(inf*[1,1,1]);
        translate([wall_t,wall_t,-inf]) linear_extrude(height=3*inf)
            polygon([[0,0],[corner_dx,0],[0,corner_dy]]);
    }
}

module corner()
{   difference()
    {   translate([-tx,-ty,-tz]) rounded_cube(dx,dy, dz, r);
        walls();
        translate([wall_tx+tx,wall_ty+ty,wall_tz+tz]) rounded_cube(inf,inf,inf, r);
        //Holes for screws.
        translate([wall_tx+tx+screw_r,wall_ty+ty+screw_r,-inf]) cylinder(r=screw_ir, h=3*inf);
        translate([-inf,wall_ty+ty+screw_r,wall_tz+tz+screw_r]) rotate([0,90]) 
            cylinder(r=screw_ir, h=3*inf);

        translate([wall_tx+tx+screw_r,-inf,wall_tz+tz+screw_r]) rotate([-90,0]) 
            cylinder(r=screw_ir, h=3*inf);
    }
}

//TODO how to print it..
corner();
