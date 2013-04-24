//
//  Copyright (C) 23-04-2012 Jasper den Ouden.(ojasper.nl)
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

hl = 80; //Length of handle.
l = 20; //Length of mirror reinforced.
mt = 2; //thickness of mirror.
t=3*mt;
r=t/4; //Rounding.
st=t/3; //walls round mirror.
s = t/2; //Length of space round mirror.

a = 45; //Angle the mirror is at. (easier to print closer to 90)

sr= 1.2; //Wire width.

module _mirror_corner()
{
    intersection()
    {   difference()
        {   cube([l,l,t]); 
            translate([st,st,mt]) cube([l,l,mt]);
            translate([2*st,2*st,mt]) cube([ml-2*st,ml-2*st,3*t]);
            translate([l,l]) cylinder(r=l-2*s, h=t);
        }
        translate([l,l])  cylinder(r=sqrt(2)*l, h=t);
    }
}

module mirror_corner()
{
    _mirror_corner();
    difference()
    {   translate([t,t,2*t/3]) sphere(t);
        translate([0,0,2*t/3 - hl]) cube(2*[hl,hl,hl],center=true);
        translate([t,t,t+sr]) rotate(45) 
        {   translate([0,hl]) rotate([90,0,0]) cylinder(r=sr,h=2*hl);
            translate([hl,0]) rotate([0,-90,0]) cylinder(r=sr,h=2*hl);
        }
    }
}

module mirror_stick_corner()
{   
    rotate([a,-a,0]/sqrt(2)) translate([0,0,t]) scale([1,1,-1]) mirror_corner();
    difference()
    {   union() 
        {   difference()
            {   translate([r,r,t/2]) rotate([0,0,-45])
                {   rotate([90,0,0]) cylinder(r=2*t/3,h=2*hl/3);
                    translate([0,-hl/2]) scale([1,(hl-t)/(2*t),1]) sphere(t);
                    translate([0,-0.9*hl]) scale([1,(0.1*hl)/t,1]) sphere(t);
                }
                translate([r,r,0]) rotate([0,0,-45]) translate([0,-0.9*hl]) scale([1,1.5,1]) 
                {   cylinder(r1=0.6*t,r2=0.4*t, h=t);
                    cylinder(r2=0.6*t,r1=0.4*t, h=t);
                }
                translate([0,0,-2*hl])  cube(hl*[4,4,4], center=true);
                translate([0,0,t+2*hl]) cube(hl*[4,4,4], center=true);
            }
            linear_extrude(height=t) polygon([[-hl/8,-hl/8],[0,l/2],[l/2,0]]);
        }
        rotate([a,-a,0]/sqrt(2)) 
        {   translate([0,0,-2*hl])  cube(hl*[4,4,4], center=true);
//        cylinder(r=t/3,h=t);
//            translate([s,s]) linear_extrude(height=t) polygon([[0,0],[0,l/2],[l/2,0]]);
        }
    }
}
mirror_stick_corner();
//rotate([0,-90,0]) mirror_corner();
