//
//  Copyright (C) 01-04-2012 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<../lib/rounded_box.scad>

module grasp_male2d(w,h)
{
    translate([w/3,0]) circle(w/6);
    translate([w*2/3,0]) circle(w/6);
    translate([w/2,0]) square([w/3,h],center=true);
}

module grasp_female2d(w,h,r)
{
    difference()
    {   union()
        {   translate([0,-h/2]) square([w,h-r]);
            translate([r,-h/2]) square([w-2*r,h]);
            translate([r,h/2-r]) circle(r);
            translate([w-r,h/2-r]) circle(r);
        }
        grasp_male2d(w,h);
    }
}

module grasp_hor()
{
    translate([-$grasp_d/2,$h/2-$r]) scale([1,-1]) linear_extrude(height=$dx) difference()
    {   union()
        {   square([2*$grasp_d, $w/3]); //translate([0,$r]) circle($r);
            translate([0,$grasp_d/2]) circle($grasp_d/2);
        }
        translate([0,$grasp_d/2]) circle($grasp_d_r);
    }
}

module grasp_head()
{   translate([0,-$h/2-$dy]) difference() 
    {   rounded_cube($w,$h+$dy,$dx+$r, $r);
        translate([-$w,-$h-$dy,$dx])
            cube([3*$w,3*($h+$dy),$l]);
    }
    if( $grasp_d>0 )
    {   grasp_hor();
    }
    
    if($round_hook) 
        translate([$w/2,$r]) rotate([0,90]) difference()
        {   rotate_extrude() translate([$dy/2,0]) circle($dy/4);
            translate([8*$r,0,0]) cube(16*$r*[1,1,1],center=true);
        }

    translate([$w/2,2.5*$r]) if($square_hook)
    {       
        cylinder(r=$r/2, h=$dx-$r/2);
        translate([0,0,$dx-$r/2]) 
        {   sphere($r/2);
            rotate([90,0,0]) cylinder(r=$r/2, h=$r);
        }
    }
}

module grasp_female()
{   grasp_head();
    translate([0,0,$dx]) linear_extrude(height=$l-$dx) 
        grasp_female2d($w,$h,$r);
}

module grasp_male()
{   grasp_head();
    translate([0,0,$dx]) linear_extrude(height=$l-$dx) 
        grasp_male2d($w,$h,$r);
}


$w = 60;
$h = $w/2;
$l = 80;
$dx = 20;
$dy = $h;
$r = 10;

$grasp_d = -2;
$grasp_d_r = -3;

$round_hook=true;

grasp_male();
translate([2*$w+10,0]) grasp_female();

