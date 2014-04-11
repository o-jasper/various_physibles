//
//  Copyright (C) 11-04-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

pt = 5;
t  = 6;
dh = 50; //Dry  side height
wh = 30; //Wet side height.

dx = 20+t;
dy = 20;

q = 3*t;

module plate_sub()
{
    translate([0,-8*dh,-4*t]) cube([pt,8*dh,8*t]);
}

module sgh_ws() //Wet side.
{
    hull()
    {   sphere(t);
        translate([0,-wh]) sphere(t);
        translate([pt,0])   sphere(t);
        translate([pt,-wh]) sphere(t);
    }
}
module sgh_ds() //Dry side.
{   difference()
    {   hull()
        {   scale(1.5) sphere(t);
            translate([0,-dh])  sphere(t);
            translate([pt,0])   sphere(t);
        }
        plate_sub(pt=8*dh);
    }
}
f=1;

module sgh_hook() //Add the hook bit.
{
    difference()
    {   translate([t,f*(dx+t/2)-dh]) hull()
        {
            translate([-dx-t,t]) sphere(t);
            translate([-dx-t,0]) sphere(t);
            translate([-t,-f*(dx+t)]) sphere(t);
//            translate([-t,t/2-f*(dx+t)]) sphere(t);
            scale([1,f,1]) rotate(180) intersection()
            {   rotate_extrude() translate([dx+t,0]) circle(t);
                translate([t,0,-dx-t]) cube(8*[dx,dx,dx]);
            }
        }
        plate_sub(pt=8*dh);
    }
}

module cut()
{   rotate_extrude() difference()
    {   translate(-t*[0,2]) square(t*[2,4]); 
        translate([2*t,0]) circle(t);
    }
    rotate([-90,0,0]) linear_extrude() difference()
    {   square(4*[t,t],center=true);
        for(x=t*[2,-2]) translate([x,0]) circle(t);
    }
}

module shower_glass_hook()
{
    difference()
    {   intersection()
        {   union()
            {   sgh_ds();
                sgh_ws();
                sgh_hook();
            }
            cube([dh*8,dh*8,1.8*t],center=true);
        }
        plate_sub();
        translate([-dx+2*t,-dh+3*t]) cut();
    }
}

shower_glass_hook();
