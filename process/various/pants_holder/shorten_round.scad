//
//  Copyright (C) 21-08-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Idea is to have a think with a hook and another thing with holes that
// both go into belt holes and can pull two belt holes together, shortening
// a section of pants.

$fs=0.1;

r=1.5;
t=3;
gl=8*r;

n=4;

e=0.5;

module belt_hole_grab()
{   difference()
    {   sphere(r+t);
        translate([t/4,0,-4*(r+t)]) linear_extrude(height=8*(r+t))
        {   circle(r);
            translate([-4*r,0]) square([gl,2*r],center=true);
        }
    }
}
module male_part()
{   translate([0,0,-t/2]) linear_extrude(height=t) intersection()
    {   difference()
        {   union()
            {   translate([-gl/2,r+t/2]) square([gl,t],center=true);
                translate([-gl,0]) circle(r+t);
                translate([0,t])circle(r);
            }
            square([2*gl+1.2*t,2*r],center=true);
            rotate(180) square([gl-t/2,8*r]);
        }
        union()
        {
            translate([0,t]) square([4*gl,2*(r+t)],center=true);
            translate([-gl-t/2,-r]) scale([1,0.7]) circle(r+t/2);
        }
    }

}

module male()
{   union(){ belt_hole_grab(); male_part(); } }

module female_part()
{
    d = 2*r+t;
    l = d*n;
    intersection()
    {   translate([0,t]) rotate([90,0,0]) linear_extrude(height=2*t) for( i = [1:n] )
        {
            translate([(i-0.5)*d,0]) scale([1,2]) circle(r-e/2);
        }
        cube([2*l,2*l,t],center=true);
    }
    translate([0,0,-t/2]) linear_extrude(height=t) difference()
    {
        union()
        {   translate([l/2,0]) square([l,3*t],center=true);
            translate([l,0]) circle(1.5*t);
            scale([1/2,1]) circle(1.5*t);
        }
        translate([l/2,0]) square([l,t+e],center=true);
        translate([l,0]) circle((t+e)/2);
    }
                   
}

module female()
{
    translate([0,r+t/2]) rotate(180) rotate([90,0,0]) female_part();
    belt_hole_grab();
}

//Both should be printed on side for best effect..
//female();
male();
