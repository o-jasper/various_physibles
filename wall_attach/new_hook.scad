//
//  Copyright (C) 25-3-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//use <nut_hole.scad>

screw_recess_r = 4;
screw_recess_d = 2;
screw_r = 2;

hook_r= 10; //Radius of hook 'tubing'.
hook_er = 6; //End of radius.
hook_l = 70;

turn_r=20; //Turn radius of hook.

wall_r = 10;  //Radius of attachment to wall.
wall_h = 4*screw_recess_r + 2*wall_r + 2*hook_r; //Height of wall attachment.

hook_a=30; 
between_a = 30; //Angle between hooks.

s=0.7; //Scale factor to flatten hooks.

module hook_part()
{
    translate([turn_r,-turn_r]) intersection()
    {   rotate_extrude() translate([turn_r,0]) circle(hook_r);
        translate(2*turn_r*[-1,0,-1]) cube(2*turn_r*[1,1,2]);
    }
    translate([turn_r,0*turn_r]) 
    { 
        sphere(hook_r);
        rotate(a= hook_a) rotate([90,0]) 
        {   cylinder(r1=hook_r, r2=hook_er, h=hook_l-hook_er);
            translate([0,0,hook_l-hook_er]) sphere(hook_er);
        }
    }
    
}

module screw_hole()
{
    translate([0,0,wall_r*s-screw_recess_d])
    {   cylinder(h=wall_h, r=screw_recess_r);
        translate([0,0,-wall_h]) cylinder(h=2*wall_h, r=screw_r);
    }
}

module hook_plain()
{
    r = wall_r; h=wall_h; d=screw_recess_r;
    difference()
    {   union()
        {   translate([0,2*screw_recess_d])
            {   translate([0,-turn_r]) scale([s,1]) 
                {   rotate([0,between_a]) hook_part();
                    rotate([0,-between_a]) hook_part();
                }
            }
            rotate([90,0]) cylinder(r=r,h=h-2*r);
            sphere(r);
            translate([0,2*r-h]) sphere(r);
        }
        translate([-2*h,0,0]) cube(4*h*[1,1,1], center=true);
    }
}

module hook()
{
    difference()
    {   translate([0,wall_r]) scale([1,-1]) rotate([0,-90,0]) hook_plain();
        translate([0,wall_r]) screw_hole();
        translate([0,wall_h-wall_r]) screw_hole();
    }
}

hook();
cube([10,10,10]);
