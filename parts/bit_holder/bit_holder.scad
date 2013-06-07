//
//  Copyright (C) 07-06-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Radius of screw.
r = 3;
//Thicknesses.
t = 4;
//Height.
h = 5*t;
//Outer thickness
ro = 9;

//Extra space.
et = 0.5;

module drill_part_profile()
{   
    difference()
    {   union()
        {   circle(ro-et);
            square([3*ro-et,t-et], center=true);
//            square([t-et, 3*ro-et], center=true);
        }
        circle(r);
    }
}

module receive_part_profile()
{  
    intersection()
    {   square((ro+1.7*t)*[2,3], center=true);
        difference()
        {   scale([2,1.3]) circle(ro+t);
            drill_part_profile(et=0);
            circle(ro);
        }
    }
}

module holder_part_profile()
{
    intersection()
    {   square((ro+1.7*t)*[2,1.7], center=true);
        difference()
        {   scale([2,1.3]) circle(ro+t);
            circle(ro);
            translate([2*ro,0]) square(ro*[4,2], center=true);
        }
    }
}

cr=t/2;
module holder_part()
{   z=2*(t-et);
    difference()
    {   union()
        {   linear_extrude(height=z) holder_part_profile();
            translate([-ro-t,ro,z]) rotate([90,0,0]) scale([1,0.7]) cylinder(r=cr,h=2*ro);
        }
        translate([-ro-t,ro]) rotate([90,0,0]) scale([1,0.7]) cylinder(r=cr,h=2*ro);
    }
}

module receive_part()
{   difference()
    {   linear_extrude(height=h) receive_part_profile();
        translate([0,0,h/2-t]) holder_part(et=0);
        rotate(-45) translate([0,ro]) cylinder(r=0.6*t,h=h);
    }
}
//Nut thickness.
nt = 5.4;
//Nut height.
nh = 2.4;

sr = 1.3;
module nut_profile()
{
    intersection()
    {   square([nt,4*nt], center=true);
        rotate(120) square([nt,4*nt], center=true);
        rotate(240) square([nt,4*nt], center=true);
    }
}

module drill_part()
{   difference()
    {   linear_extrude(height=h) drill_part_profile();
        translate([0,0,h/2-t]) holder_part(et=0);
        
        rotate(-45) translate([0,r+nh,1.5*nh]) rotate([90,0,0]) union()
        {   linear_extrude(height=nh)
            {   nut_profile();
                translate([0,h]) square([nt,2*h],center=true);
            }
            for( z= [1.5*nh: 3*nh : h-3*nh] ) translate([0,z,-r]) cylinder(r=sr,h=2*r);
        }
    }
}

module as_print()
{   translate([0,0,ro+1.7*t]) rotate([0,90,0]) receive_part();
    translate([0,4*ro]) holder_part();
    translate([0,-4*ro]) drill_part();
}

module as_show()
{
    receive_part();
    color([0,0,1]) drill_part();
    color([1,0,0]) translate([0,0,h/2-t]) holder_part();
}
//as_show();
as_print();
