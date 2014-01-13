//
//  Copyright (C) 15-2-2013 Jasper den Ouden.
//
//  This is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published
//  by the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//

// NOTE/TODO
// * under hooks probably not printable on its back(horns do slightly better)
// * very square..
// * lay it flat on the back in the first place.

//Very square-ish hook coat hanger.

h=100;
t=20;
d=50;
dh = 60;
a=45;

module upper_catch()
{
    difference()
    {
        intersection()
        {   square([d+t,h+dh]);
            translate([t-d,h+dh]) scale([1,(dh+t)/(sqrt(3)*d)]) circle(2*d);
        }
        translate([-d,h+dh]) scale([1,dh/(sqrt(3)*d)]) circle(2*d);
    }
    translate([d+t/2,h+dh]) circle(t/2);
}

module lower_catch()
{   translate([0,-t]) 
    {   difference() 
        {   intersection()
            {   square([d+2*t,dh]);
                translate([t+d/2,dh]) scale([(d/2+t)/dh,1]) circle(dh);
            }
            translate([t+d/2,dh]) scale([d/(2*(dh-t)),1]) circle(dh-t);
        }
        polygon([[0,t], [t,t], [t+d/2,0]]);
    }
    square([t,dh]);
    translate([d+1.5*t,dh-t]) circle(t/2);
}

module flat_hook2d()
{   square([t,h]);
    upper_catch();
    lower_catch();
}

module flat_hook()
{   linear_extrude(height=t) flat_hook2d(); }

module two_nose_hook()
{
    //TODO bull hook but two lower catches instead.
}

module bull_hook()
{ 
    translate([0,0,-t/2]) linear_extrude(height=t)
    {
        square([t,h]);
        lower_catch();
    }
    
    difference()
    {   union()
        {   translate([0,h]) rotate(a=a, v=[0,1]) translate([0,-h,-t/2])
                linear_extrude(height=t) upper_catch();
            translate([0,h]) rotate(a=-a, v=[0,1]) translate([0,-h,-t/2])
                linear_extrude(height=t) upper_catch();
            translate([t/2,h,-t]) cylinder(r=t/2,h=2*t);
        }
        translate([-4*h,0,0]) cube(8*h*[1,1,1], center=true);
        //Bit ugly way to get rid of cylinder bits.
        rotate(v=[0,1,0], a=a) translate([-4*h-t/2,0,0]) cube(8*h*[1,1,1], center=true);
        rotate(v=[0,1,0], a=-a) translate([-4*h-t/2,0,0]) cube(8*h*[1,1,1], center=true);
    }
}

rotate(v=[1,0,0], a=90) bull_hook();
