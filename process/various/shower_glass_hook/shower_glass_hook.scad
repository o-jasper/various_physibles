//
//  Copyright (C) 11-04-2014 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

$fs=0.4;

pt = 6.2; //Plate thickness.
t  = 6;
th = t;
dh = 50;  //Dry  side height
wh = 30;  //Wet side height.

dx = 20+t; //Position of 'ball'.
dy = 20;

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
            translate([0,-dh])  scale([1.5,1,1]) sphere(t);
            translate([pt,0])   sphere(t);
        }
        plate_sub(pt=8*dh);
    }
}
f=1;

module sgh_hook() //Add the hook bit.
{
    difference()
    {   
        hull()
        {   translate([-dx/2,dy/2-dh]) scale([dx,dy]/dx) rotate_extrude()
            {   translate([dx/2,0]) scale([th,t]/t) circle(t); 
            }
            translate([0,-dh]) scale([th,th,t]/t) sphere(t);
        }
        plate_sub(pt=8*dh);
        rotate(270) translate([-dx/2,dy/2-dh,-dh]) cube([dh,dh,8*dh]);
    }
    translate([-dx,dy-dh]) scale([th,th,t]/t) hull()
    {   sphere(t);
        translate([0,-dy/2]) sphere(t);
        translate([th/2,-dy/2]) sphere(t);
    }
}

module cut()
{   rotate_extrude() difference()
    {   translate(-t*[0,2]) square(t*[2,4]); 
        translate([2*t,0]) scale([th,t]/t) circle(t);
    }
    rotate([-90,0,0]) linear_extrude() difference()
    {   square(4*[t,t],center=true);
        for(x=t*[2,-2]) translate([x,0]) scale([th,t]/t) circle(t);
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
        translate([-dx/2,0.8*t+dy/2-dh]) cut();
    }
}

shower_glass_hook();
