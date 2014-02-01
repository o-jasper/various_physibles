//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

//All plates are the same.
module side_plate()
{
    fz= (min_z+bh+fh)/2;
    translate([pt,0]) rotate([0,-90,0]) linear_extrude(height=pt) difference()
    {   square([h,l-pt]);
        translate([fz,l/4]) square([h-fz-fh,2*l]);
    }
}

