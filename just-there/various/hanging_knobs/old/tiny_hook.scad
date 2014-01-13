//
//  Copyright (C) 25-3-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//TODO this one is shit.

use <nut_hole.scad>

plate_w=10;

cut_r = 10;
cut_R = 20;

hook_h = 50;
hook_w = hook_h/4;
hook_d = 2*(2*plate_w + cut_r);

between_a = 60;

module tiny_hook_cut()
{
    translate([0,plate_w + cut_r]) 
    {   rotate([90,0]) translate([0,-cut_R]) 
            rotate_extrude() translate([cut_R,0]) circle(cut_r);
        translate([0,0,2*cut_R]) 
            cube([2*cut_R,2*cut_r,4*cut_R], center=true);
        translate([-cut_R,0]) rotate([0,90]) cylinder(r= cut_r, h=2*cut_R);
    }
}

module tiny_hook_base()
{
    h=hook_h;
    intersection()
    {   difference()
        {   scale([hook_w/h,hook_d/h,1]) sphere(h);
            tiny_hook_cut();
        }
        sphere(2*(cut_r+plate_w));
//        rotate([0,90]) translate([0,0,-cut_R]) cylinder(r=2*(cut_r+plate_w), h = 4*cut_R);
        translate([0,2*cut_R,0]) cube(4*cut_R*[1,1,1], center=true);
    }
}

tiny_hook_base();


translate([40,0]) cube([10,10,10]);

