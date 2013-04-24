//
//  Copyright (C) 21-04-2013 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

al=5;
//attach_methods(1.2,1,1);

module attach_place(h)
{   for( y = [0 : 2*al :h] ) translate([0,y])
    {
        rotate([0,90,0]) linear_extrude(height = al) translate([-3.5*al,0]) difference()
        {   union()
            {   square([3.5*al,al]);
                translate([0,al/2]) circle(al/2);
            }
            translate([0,al/2]) circle(al/4);
        }

        translate([+al,0,0]) 
        {   cube([1.5*al,al,al]); 
            translate(al*[1.5,1/2]) cylinder(r=al/2, h=3*al); 
        }
    }
}
