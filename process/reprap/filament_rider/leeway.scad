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

$fs=0.2;

fr=2; //Radius of filament.(over-estimated)
R=20; t=2;

//TODO crap, CGAL does not like.

module leeway_spacer_plain()
{
    rotate([-90,0,0]) intersection()
    {   union()
        {   rotate_extrude() hull()
            {   circle(fr+t);
                translate([R-fr-t,0]) circle(fr+t);
            }
            translate([0,fr+t,0]) rotate([90,0,0]) cylinder(r=fr+t,h=R);
        }
        rotate([90,0,0]) difference()
        {   scale([1,0.8,1]) union()
            {   cylinder(r1=fr+t,r2=R,h=R);
                translate([0,0,-fr-t]) cylinder(r1=fr+t,r2=R/2,h=R+fr+t);
            }
            hull() for(a=[-40,0,40]) rotate([0,a,0]) cylinder(r=fr,h=2*R);
            translate([0,0,-R]) cylinder(r=fr,h=2*R);
        }
    }
}

//TODO pretification?

leeway_spacer_plain();
