//
//  Copyright (C) 11-03-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

//Rotating thing that keeps away the tube i have on the filament to prevent
// breaks.

$fs=0.1;

fr=2; //Radius of filament.(over-estimated)
R=20; t=2;

//TODO crap, CGAL does not like.

module leeway_spacer_plain()
{
    rotate([-90,0,0]) intersection()
    {   union()
        {   scale([1,1,0.8]) sphere(R);
            translate([0,fr+t,0]) rotate([90,0,0]) cylinder(r=fr+t,h=R);
        }
        rotate([90,0,0]) difference()
        {   union()
            {   scale([1,0.8,1]) cylinder(r1=fr+t,r2=R,h=R);
                translate([0,0,-fr-t]) cylinder(r1=fr+0.7*t,r2=R/2.5,h=R+fr+t);
            }
            hull() for(a=[-40,0,40]) rotate([0,a,0]) scale([0.5,1,1]) cylinder(r=fr,h=2*R);
            translate([0,0,-R]) cylinder(r=fr,h=2*R);
        }
        cube([8*R,8*R,2*(fr+t)],center=true);
    }
}

use<logos/openhw.escad>

module pretty_pos_f()
{   translate([0,-fr-t+0.1,R/2]) rotate([90,0,0]) child(0); }
module pretty_pos_b()
{   rotate(180) pretty_pos_f() child(0); }

//This looks too much like some logo i dont know.
module lines()
{   translate([0,-R/2]) for(a=[0,30,-30]) rotate(a) hull()
    {   translate([0,3*t+t*a*a/900]) scale([1,1,0.5]) sphere(t/2);
        translate([0,R-2*t-t*a*a/1800]) scale([2,2,1]) sphere(t/2);
    }
}
module reprap_logo()
{
    translate([0,-t/2]) hull()
    {   scale([1,1,2*t/R]) sphere(R/3); 
        //This being a sphere makes it an approximation.
        translate([0,sqrt(2)*R/3-t/4]) sphere(t/4);
    }
}

module leeway_spacer_prettify()
{
    leeway_spacer_plain(fr=fr,R=R,t=t);
    pretty_pos_f() linear_extrude(height=t/4) oshw_logo_2d(R-2*t);
    pretty_pos_b() reprap_logo();
}
leeway_spacer_prettify();
