//
//  Copyright (C) 09-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Version more specific about how the z rod is held.
//Note that it probably doesnt help much at all. The corner pieces could help
// more but ultimately..
//
// Hmm, perhaps a steel crossbar vertically would be the most efffective against
// x-wobble? Basically tighten it there.

rr = 10; //Z-rod radius.
rb = 10; //Horizontal rod radius.
t = 6; //Thickness.
l = 6*(rr+t); //Length. (> 2* is extra)
h = l;  //height(idem)

sr = 3; //Smaller screw radius.

cd = 4; //width of cut for the clamping.

d = rr+rb+2*t;//Distance between rods. TODO

cw = 2*t+cd; //Width of clamp on top.
cr = sr + t; //Radius, idem.

module z_rod_holder()
{
    difference()
    {
        union()
        {
            translate([rr+t,d,-rr-t]) 
            {   cylinder(r=rr+t, h = h-t);
                translate([0,0,h-t]) sphere(rr+t);
            }
            
            translate([rr+t,d/2]) cube(2*[rr+t,d/2,rb+t], center=true);
            rotate([0,90]) cylinder(r=rb+t, h = l);
            translate([l/2,0,-(rb+t)/2]) cube([l,1.2*(rb+t),rb+t], center=true);

            
            translate([rr+t-cw/2,rr+t-sr,h-rr-t-cr]) rotate([0,90]) linear_extrude(height=cw)
                difference()
            {   rotate(45)  union()
                {   circle(cr);
                    translate([cr,0]) square(2*[cr,cr], center=true);
                }
                circle(sr);
            }
            translate([l-t,0]) rotate(180-atan(d/(l-t-rr-t))) rotate([0,45])//atan(h/(l-t))]) 
                cylinder(r=1.5*t,h=200);
        }
        translate([rr+t,d,-rr-t-h]) cylinder(r=rr, h = 3*h);
        translate([-l,0]) rotate([0,90]) cylinder(r=rb, h = 3*l);
        translate([rr+t,2*(rr+t)-(l+h)/2]) cube([cd,l+h,3*h], center=true);
        translate([0,0,2*h+l-rb-t]) cube(2*(h+l)*[1,1,1], center=true);
    }
}

z_rod_holder();
