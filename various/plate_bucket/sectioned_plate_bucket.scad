//
//  Copyright (C) 19-06-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.5;
t = 4;
w = 115;

pt=0.7;
wr=1;

h=100;

//TODO plate space, corners and top.

module quarter2d()
{   union()
    {   translate([t,t]) circle(t);
        translate([t,0]) square([w/2-t,w/2]);
        translate([0,t]) square([w/2,w/2-t]);
    }
}

module floor_sub()
{
    difference()
    {   intersection()
        {   quarter2d();
            translate([t+pt,t+pt]) quarter2d();
        }
        translate([w/2,0]) circle(3*t);
        translate([0,w/2]) circle(3*t);
        translate([w/2-2*t,w/2-2*t]) square(3*[t,t]);
    }
}

module bottom_section()
{
    difference()
    {   union()
        {   linear_extrude(height=t) difference() //With hole for floor.
            { quarter2d(); translate(1.5*[w,w]/8) square([w,w]/8); }
            linear_extrude(height=3*t) difference()
            {   quarter2d();
                floor_sub();
            }
            linear_extrude(height=h/3) difference()
            {   translate([t,t]) circle(t);
                translate([2*t+pt,2*t+pt]) circle(t);
            }
        }
        translate([w/2,t+pt+1.2*wr,2*t]) cube([w/2,2*wr,2*wr],center=true);
        translate([t+pt+1.2*wr,w/2,2*t]) cube([2*wr,w/2,2*wr],center=true);

        translate([0,0,t]) linear_extrude(height=h) difference()
        {   union()
            {   translate([t/2,t/2]) square([pt,w]);
                translate([t/2,t/2]) square([w,pt]);
            }
            rotate(-45) square([pt,w],center=true);
        }
        for( x = [ 2*t : 2*t : w/2-2*t] ) translate([x,t/4,2*t]) cube(2*[pt,t,pt]);
        for( y = [ 2*t : 2*t : w/2-2*t] ) translate([t/4,y,2*t]) cube(2*[t,pt,pt]);
    }
}

module corner_section(h=h/3)
{
    translate([0,0,t]) linear_extrude(height=h) difference()
    {   translate([t,t]) circle(t);
        translate([2*t+pt,2*t+pt]) circle(t);        
        difference()
        {   union()
            {   translate([t/2,t/2]) square([pt,w]);
                translate([t/2,t/2]) square([w,pt]);
            }
            rotate(-45) square([pt,w],center=true);
        }
    }
}
//corner_section();
bottom_section();
module floor_section()
{
    difference()
    {   linear_extrude(height=2*t) floor_sub();
        translate([w/2,w/2,2*t]) 
            for(a=[-90,0]) rotate(a) union()
            {   rotate([90,0,0]) translate([0,0,w/4]) cylinder(r=sqrt(2)*t,h=w, $fn=4);
                translate([0,-w/2,-t]) cylinder(r=3*t+wr,h=t);
            }
        
    }
    translate(1.5*[w,w]/8) cube([w/8,w/8,3*t]);
}

translate([w,0]) floor_section();
