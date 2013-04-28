//
//  Copyright (C) 09-04-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

t=5;

rr = 9.6; //Z-rod radius.
rb = 10; //Horizontal rod radius.
hd = 20; //Horizonal rod distance
d = rr+rb+2*t;//Distance between rods. TODO
z=20;

al=5;
sr=1.2;

//Slide-on and clamp.
module _bottom()
{
    tz = z+3*t;
    w=3*(rb+t)/2;
    translate([hd,d]) rotate([0,90,0]) linear_extrude(height=5*t) difference()
    {   union()
        {   circle(rb+t);
            translate([-tz/2,0]) square([tz,w], center=true);
        }
        circle(rb);
    }
    hx = hd+2.5*t; hl= 2*rb+t+3*sr; //Plate for screws.
    translate([hx,d,tz-t]) linear_extrude(height=t) difference()
    {   union()
        {   square([3*sr+t,hl],center=true);
            translate([0,+hl/2]) circle(3*sr/2+t/2);
            translate([0,-hl/2]) circle(3*sr/2+t/2);
        }
        translate([0,+hl/2]) circle(sr);
        translate([0,-hl/2]) circle(sr);
    }

    translate([0,0,z]) linear_extrude(height=3*t) difference()
    {   union()
        {   circle(rr+t);
            translate([0,d-rr]) circle(rr);
            translate([0,d]) circle(rr/2);
            translate([3*rr/2,d]) square([3*rr,rr], center=true);
            translate([hd-al,d]) circle(al+t);
            translate([hd+al+5*t,d]) circle(al+t);
            translate([hx,d]) square([2*al+5*t,2*(al+t)],center=true);
        }
        translate([hd-al,d]) circle(al);
        translate([hd+al+5*t,d]) circle(al);
        circle(rr);
        translate([0,d-rr]) circle(rr-t);
        square([rr/2,rr+d], center=true);
        translate([0,-rr-t]) scale([1/2,1]) rotate(45) square(2*[t,t],center=true);
    }
}

module clamper()  
{   y = t+2*rb;
    r = sqrt(4*rb*rb + y*y)/2;
    translate([hd+3.5*t,d+t,-rb-t]) rotate([0,-90,0]) 
        linear_extrude(height=2*t) difference()
    {   union()
        {   polygon([[0,0],[2*y,0], [2*y,y],[0,y]]);//square([2*y,y]);
            translate([2*y/3,y]) circle(2*y/3);
        }
        translate([1.25*y,0]) scale([1,1/2]) circle(y/2);
        translate([2*y,y]) scale([2/3,(y-rb+t)/y]) circle(y);
        translate([2*y/3,y]) circle(2*y/3-t);
    }
}
module bottom()
{
    difference()
    {   _bottom();
        translate([hd+t,d,-rb-t]) cube([3*t,3*t, z+rb+3*t]);
    }
    clamper();
}


module as_print()
{   rotate([0,180,0]) bottom(); }
as_print();
