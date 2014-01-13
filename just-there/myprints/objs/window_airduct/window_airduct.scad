//
//  Copyright (C) 01-04-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

use <../graspers/grasp.scad>


$w = 60;
$h = $w/2;
$l = 80;
$dx = 20;
$dy = $h;
$r = 10;

$round_hook=true;

module hinge_bolt()
{ 
    difference()
    {   translate([-$w/2,0,2*$r/3]) rotate([0,90]) union()
        {   sphere($r);
            cylinder(r=$r, h=2*$w);
            translate([0,0,2*$w]) sphere($r);
        }
        translate(-2*$w*[0,0,1]) cube(4*$w*[1,1,1], center=true);
    }
}
/*
grasp_male();
hinge_bolt();

translate([0,2*$h+$r+10]) 
{   grasp_female();
//    hinge_bolt();
}
*/
real_fan_r = 80;
d = $r/2;
t = $r+d;

fan_dx = 10;
fan_dr = 2;

fan_base_w =100;

fan_w = max(2*real_fan_r + 4*$r+2*d, fan_base_w + 2*($r+2*d));


//TODO one end goes onto the cylinder, other end fits the corner.
module fan_side2d()
{
    difference()
    {   union()
        {   circle($r+d);
            square([fan_w,$r+d]);
            translate([fan_w,0]) circle($r+d);
        }
        circle($r);
        translate([fan_w,0]) circle($r);
    }
}

module fan_end()
{
    difference()
    {   rotate([-90,0]) linear_extrude(height= fan_w) fan_side2d();
        translate(fan_w*[1,1,-2]/2) cylinder(r=real_fan_r, h = 4*fan_w);
    }
}

fan_end();
/*

module fan_end()
{
    linear_extrude(height=t) difference()
    {   translate([$r,0]) square([fan_w-2*$r, fan_w]);
        translate([fan_w/2,fan_w/2]) circle(real_fan_r+d);
    }
//    translate([]
    fan_pillar();
    translate([fan_w,0]) fan_pillar();
}
fan_end();
*/
