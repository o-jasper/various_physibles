//
//  Copyright (C) 04-01-2014 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

include<params.scad>

module side_plate2d()
{
    echo("Outers:",h,l-pt);
    fz= (min_z+bh+fh)/2;
    echo("cut: from bottom:", fz, "from top:", fh,"from_side:", l/4);
    if( fz+(h-fz-fh)+fh != h ) echo("something wrong");
    difference()
    {   square([h,l-pt]);
        translate([fz,l/4]) square([h-fz-fh,2*l]);
    }
}

//All plates are the same.
module side_plate()
{
    translate([pt,0]) rotate([0,-90,0]) linear_extrude(height=pt) side_plate2d();
}

side_plate2d();
