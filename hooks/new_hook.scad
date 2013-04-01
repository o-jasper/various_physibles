//
//  Copyright (C) 25-3-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use <nut_hole.scad>

//Info on screw.
screw_recess_r = 4;
screw_recess_d = 2;
screw_r = 2;

hook_r= 5; //Radius of hook 'tubing'.
hook_er = 3; //End of radius.
hook_l = 20;

turn_r=30; //Turn radius of hook.

wall_r = 7;  //Radius of attachment to wall.
wall_top_r = 7;
wall_h = 5*screw_recess_r + 2*wall_r; //Height of wall attachment.

hook_a=60; 
between_a = 20; //Angle between hooks.

s=0.7; //Scale factor to flatten hooks.

module hook_part()
{
    translate([turn_r+hook_r,-turn_r]) intersection()
    {   rotate_extrude() translate([turn_r,0]) circle(hook_r);
        translate(2*turn_r*[-1,0,-1]) cube(2*turn_r*[1,1,2]);
    }
    translate([hook_r,-turn_r]) sphere(hook_r);
    translate([turn_r+hook_r,0]) 
    { 
        sphere(hook_r);
        rotate(a= hook_a) rotate([90,0]) 
        {   cylinder(r1=hook_r, r2=hook_er, h=hook_l-hook_er);
            translate([0,0,hook_l-hook_er]) sphere(hook_er);
        }
    }
    
}

module hook_screw_hole()
{   translate([0,0,wall_r*s])
        plain_screw_hole(screw_r,screw_recess_r,screw_recess_d, wall_h,wall_h);
}

module horn() //TODO small top hooks.
{
    r = hook_er/2; h = hook_l/3;
    translate([0,2*wall_r-wall_h - wall_r*cos(between_a)/2, wall_r*sin(between_a)/2])
        rotate([0,hook_a]) rotate([90-between_a,0]) 
    {
        cylinder(r1=2*r, r2=r, h = h-r);
        translate([0,0,h-r]) sphere(r);
    }
}

module hook_plain()
{
    h=wall_h; d=screw_recess_r;
    y = - h+wall_r+wall_top_r;
    difference()
    {   intersection()
        {   union()
            {   translate([-s*wall_r/2,0]) scale([s,1]) 
                {   rotate([0,between_a]) hook_part();
                    rotate([0,-between_a]) hook_part();
                }
                rotate([90,0]) cylinder(r1=wall_r,r2=wall_top_r,h=h-wall_r - wall_top_r);
                sphere(wall_r);
                translate([0,wall_r+wall_top_r-h]) sphere(wall_top_r);
            }
            union()
            {   translate([0,y+2*turn_r]) cube(4*turn_r*[1,1,1],center=true);
                translate([0,y]) scale([sqrt(2)*hook_r/wall_top_r,1,2*hook_r/wall_top_r]) 
                    sphere(wall_top_r);
            }
        }
        translate([-2*h,0,0]) cube(4*h*[1,1,1], center=true);
    }
}

module new_hook()
{
    difference()
    {   translate([0,wall_r]) scale([1,-1]) rotate([0,-90,0]) hook_plain();
        translate([0,wall_r]) hook_screw_hole();
        translate([0,wall_h-wall_r]) hook_screw_hole();
    }
}

new_hook();
